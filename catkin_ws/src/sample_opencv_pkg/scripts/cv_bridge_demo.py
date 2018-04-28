#!/usr/bin/env python
# -*- coding: utf-8 -*-
""" cv_bridge_demo.py - Version 0.1 2011-05-29

    A ROS-to-OpenCV node that uses cv_bridge to map a ROS image topic and optionally a ROS
    depth image topic to the equivalent OpenCV image stream(s).
    
    Created for the Pi Robot Project: http://www.pirobot.org
    Copyright (c) 2011 Patrick Goebel.  All rights reserved.

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details at:
    
    http://www.gnu.org/licenses/gpl.html
      
"""

import roslib
#roslib.load_manifest('robot_vision')
import rospy
import sys
import cv2
#import cv2.cv as cv
from sensor_msgs.msg import Image, CameraInfo
from cv_bridge import CvBridge, CvBridgeError
from geometry_msgs.msg import Twist
from myserial.msg import vehicleControl
import numpy as np
import math


guideLine = np.zeros([20,3],np.int8)  #three col   L_line  R_line  wide
class cvBridgeDemo():
    def __init__(self):
        self.node_name = "cv_bridge_demo"
        
        rospy.init_node(self.node_name)
        
        # What we do during shutdown
        rospy.on_shutdown(self.cleanup)
        
        # Create the cv_bridge object
        self.bridge = CvBridge()
        
        # Subscribe to the camera image and depth topics and set
        # the appropriate callbacks
        self.image_sub = rospy.Subscriber("/kinect2/qhd/image_color", Image, self.image_callback)
        #self.depth_sub = rospy.Subscriber("/camera/depth/image_raw", Image, self.depth_callback)
#        self.img_pub = rospy.Publisher("turtle1/cmd_vel",Twist)
        self.cmdSend = rospy.Publisher("command01",vehicleControl)
        rospy.loginfo("Waiting for image topics...")
        
        cmd = Twist()  
        cmd.linear.x = 0  
        cmd.linear.y = 0  
        cmd.linear.z = 0  
        cmd.angular.z = 0  
        cmd.angular.z = 0  
        cmd.angular.z = 0  
        self.cmd = cmd  
	
        vehcmd = vehicleControl()
        vehcmd.visual_x = 0
        vehcmd.visual_z = 0
        self.vehcmd = vehcmd
    	
    def image_callback(self, ros_image):
        # Use cv_bridge() to convert the ROS image to OpenCV format
        try:
            frame = self.bridge.imgmsg_to_cv2(ros_image, "bgr8")
        except CvBridgeError, e:
            print e
        
        # Convert the image to a Numpy array since most cv2 functions
        # require Numpy arrays.
#        frame = np.array(frame, dtype=np.uint8)
        gray = grayscale(frame)    # 540*960
        reduceGray = resize(gray,0.2,interpolation=cv2.INTER_CUBIC)   #  108*192
        roi_image = getRoi(reduceGray,80,100,19,171)
#        print reduceGray.shape
        h,w = roi_image.shape
        
        #ostu threshold image
        ret1,ostu_image = cv2.threshold(roi_image,0,255,cv2.THRESH_BINARY+cv2.THRESH_OTSU)  
#        image, contours, hierarchy = cv2.findContours(ostu_image,cv2.RETR_TREE,cv2.CHAIN_APPROX_SIMPLE)  
#        cv2.drawContours(roi_image,contours,-1,(0,0,255),3)  
        #fixed threshould image
#        ostu_image = cv2.threshold(roi_image,0,255,cv2.THRESH_BINARY)
#        ostu_image = ostu(roi_image)
        h_ostu,w_ostu = ostu_image.shape
        L_list = []
        R_list = []
        continuousJudue = []
        L_sum = 0
        L_error = 0
        '''!!!'''
        min_wide = 3
        max_wide = 30 
        
        contineThre = 5
        startSearch = h - 10
        notContine = 0
        for x in range(startSearch,h)[::-1]:
            L,R = rowDetection(ostu_image,x,0,w_ostu)
            print 'LR',L,R
            if len(L) == 1 and len(R) == 1:
                wide = R[0] - L[0]
                if wide > min_wide and wide < max_wide:
                    L_list.append(L[0])
                    R_list.append(R[0])
         
        evenNum = L_list[1::2]
        oddNum = L_list[::2]
        if len(evenNum) == len(oddNum):
            continuousJudue = np.array(evenNum) - np.array(oddNum)
        else:
            oddNum.pop()
            continuousJudue = np.array(evenNum) - np.array(oddNum)
        print  "continuousJudue",continuousJudue
        '''!!!'''
        for i in range(continuousJudue.shape[0]-1):
            if continuousJudue[i] >  contineThre:
                notContine += 1
        print "notContine",notContine
        if notContine <  4:
            
            for x in range(startSearch)[::-1]:
                if len(L_list) > 0 and len(R_list) > 0 :
                    if L_list[-1] > 10:
                        secondSearchL = L_list[-1] - 10
                    else:
                            secondSearchL = 0
                    if R_list[-1] < (w_ostu-10):
                        secondSearchR = R_list[-1] + 10
                    else:
                        secondSearchR = w_ostu
                    L,R = rowDetection(ostu_image,x,secondSearchL,secondSearchR)
                    if len(L) == 1 and len(R) == 1:
                        L_list.append(L[0])
                        R_list.append(R[0])
                
            print "L_list",L_list
            print "R_list",R_list
               
        
        
        cv2.line(roi_image,(L_list[-1],1),(L_list[0],19),[255,0,0],2) 
        cv2.line(roi_image,(R_list[-1],1),(R_list[0],19),[255,0,0],2)
        cv2.namedWindow("roi_image", cv2.WINDOW_NORMAL)
        cv2.moveWindow("roi_image", 50, 75)
        cv2.imshow("roi_image", roi_image)
        cv2.waitKey(3)
        
        cv2.namedWindow("Img", cv2.WINDOW_NORMAL)
        cv2.moveWindow("Img", 500, 75)
        cv2.imshow("Img", reduceGray)
        cv2.waitKey(3)
        
        cv2.namedWindow("ostuImg", cv2.WINDOW_NORMAL)
        cv2.moveWindow("ostuImg", 50, 500)
        cv2.imshow("ostuImg", ostu_image)
        cv2.waitKey(3)  
#        print L_list
        
        
                
        for i in range(len(L_list)-1):
            L_sum = L_sum + L_list[i]
        L_aver = L_sum / len(L_list)
        L_error = L_list[len(L_list)-1] - L_aver
        print 'L_error',L_error
            
        if L_error > 7:
#            self.cmd.linear.x = 1
#            self.cmd.angular.z = 1
            self.vehcmd.visual_z = 2
#            self.vehcmd.visual_x = 1
        elif L_error < -1:
            self.vehcmd.visual_z = 1
#            self.vehcmd.visual_x = 1
        else:
             self.vehcmd.visual_z = 3
#            self.vehcmd.visual_x = 1
        
#         if L_error < 5:
#            self.cmd.linear.x = 1
#            self.cmd.angular.z = 1
#            self.vehcmd.visual_z = 1
#            self.vehcmd.visual_x = 1
            
#         if L_error >0 and L_err
            
#            or < 4:
#            self.cmd.linear.x = 1
#            self.cmd.angular.z = 1
#            self.vehcmd.visual_z = 3
#            self.vehcmd.visual_x = 1
            
    	 
        
        
#        self.img_pub.publish(self.cmd)
        self.cmdSend.publish(self.vehcmd)
                
    def depth_callback(self, ros_image):
        # Use cv_bridge() to convert the ROS image to OpenCV format
        try:
            # The depth image is a single-channel float32 image
            depth_image = self.bridge.imgmsg_to_cv(ros_image, "32FC1")
        except CvBridgeError, e:
            print e

        # Convert the depth image to a Numpy array since most cv2 functions
        # require Numpy arrays.
        depth_array = np.array(depth_image, dtype=np.float32)
                
        # Normalize the depth image to fall between 0 (black) and 1 (white)
        cv2.normalize(depth_array, depth_array, 0, 1, cv2.NORM_MINMAX)
        
        # Process the depth image
        depth_display_image = self.process_depth_image(depth_array)
    
        # Display the result
        cv2.imshow("Depth Image", depth_display_image)
          
    def process_image(self, frame):
        # Convert to greyscale
        grey = cv2.cvtColor(frame, cv2.CV_BGR2GRAY)
        
        # Blur the image
        grey = cv2.blur(grey, (7, 7))
        
        # Compute edges using the Canny edge filter
        edges = cv2.Canny(grey, 15.0, 30.0)
        
        return edges
    
    def process_depth_image(self, frame):
        # Just return the raw image for this demo
        return frame
    
    def cleanup(self):
        print "Shutting down vision node."
        cv2.destroyAllWindows()   

def grayscale(img):
	"""Applies the Grayscale transform
	This will return an image with only one color channel
	but NOTE: to see the returned image as grayscale
	you should call plt.imshow(gray, cmap='gray')"""
	return cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)        
        
def resize(im,ratio,interpolation=cv2.INTER_CUBIC):
    im_resize = im.copy()
    new_h = int(im_resize.shape[0]*ratio)
    new_w = int(im_resize.shape[1]*ratio)
    im_resize = cv2.resize(im_resize, (new_w, new_h), interpolation=interpolation)
    return  im_resize

def getRoi(image,h1,h2,w1,w2):
    new_gray = image[h1:h2,w1:w2]
    return new_gray
    

    
def rowDetection(ostu_threshold,row,startCol,endCol):
    '''ostu_threshold :input image
       row : compute image row
    '''
    boundaryL = []
    boundaryR = []
    if startCol < 5:
        a = 0 
    else:
        a = startCol
    w = ostu_threshold.shape[1]
    if endCol > (w - 7):
        b =  w - 7
    else:
        b = endCol
        
        
    
    for j in range(a,b):
        if ostu_threshold[row][j]==255 and ostu_threshold[row][j+1]==255 and ostu_threshold[row][j+2] == 0 :
            if ostu_threshold[row][j+3]==0 and ostu_threshold[row][j+4] == 0 and ostu_threshold[row][j+5] == 0:
                if ostu_threshold[row][j+6] == 0 and ostu_threshold[row][j+7] == 0:
#                    boundaryLine[row][j] =200
                    boundaryL.append(j)
                    
                    
        if ostu_threshold[row][j]==0 and ostu_threshold[row][j+1]==255 and ostu_threshold[row][j+2] == 255 :
            if ostu_threshold[row][j-1]==0 and ostu_threshold[row][j-2] == 0 and ostu_threshold[row][j-3] == 0:
                if ostu_threshold[row][j-4] == 0 and ostu_threshold[row][j-5] == 0:
#                    boundaryLine[row][j] = 200
                    boundaryR.append(j)
                    
#    boundaryL.sort()
#    boundaryR.sort()
#    if len(boundaryL) != 0 and len(boundaryR)!=0:
#        for k in range(len(boundaryR)):
#            if boundaryL[0] > boundaryR[k]:
#                boundaryR[k] = 0
#        if 0 in boundaryR:
#            boundaryR.remove(0) 
#        for k in range(len(boundaryL)):
#            if boundaryR[len(boundaryR)-1] < boundaryL[k]:
#                boundaryL[k] = 0
#        if 0 in boundaryL:        
#            boundaryL.remove(0)
#        
#        
#        if len(boundaryL) == 1:
#            guideLine[row][0] = boundaryL[0] 
#        if len(boundaryR) == 1:
#            guideLine[row][1] = boundaryR[0] 
#        if len(boundaryL) == 1 and  len(boundaryR) == 1:    
#            guideLine[row][2] = boundaryR[0] - boundaryL[0]

    return  boundaryL,boundaryR  
    
def main(args):       
    try:
        cvBridgeDemo()
        rospy.spin()
    except KeyboardInterrupt:
        print "Shutting down vision node."
        cv.DestroyAllWindows()

if __name__ == '__main__':
    main(sys.argv)
    
