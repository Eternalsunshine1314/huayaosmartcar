#!/usr/bin/env python
# license removed for brevity
import rospy
from std_msgs.msg import String
from myserial.msg import vehicleControl
import random
import requests
r=requests.get ('http://10.139.23.100:8080/BackControl/get?CarCode=3')
a=r.json()
print a['carState']
print type(a['route'])
b=str( a['carState'])

def talker():
    pub = rospy.Publisher('command', vehicleControl, queue_size=10)
    rospy.init_node('vistHttp', anonymous=True)
    r = rospy.Rate(10) # 10hz
    
    while not rospy.is_shutdown():
#       str = "hello world %s"%rospy.get_time()
	#num = str(random.randint(0,3))	
        #rospy.loginfo(num)
        if a['route']:
	    if b=="REACH":
		print "停车"
		vehicleControl.visual_x=1
	    else:
		print '开车'        
	    	vehicleControl.visual_x=0
	else:
	    print "不开车"
	    vehicleControl.visual_x=2

	pub.publish(vehicleControl)
	r.sleep()

if __name__ == '__main__':
    try:
        talker()
    except rospy.ROSInterruptException: pass






