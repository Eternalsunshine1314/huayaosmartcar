#include "ros/ros.h"  
#include <serial/serial.h>  
#include <std_msgs/String.h>  
#include <std_msgs/Empty.h>  
#include "sensor_msgs/JointState.h"  
#include <string>  
#include <sstream>  
#include "myserial/vehicleControl.h"
serial::Serial ros_ser;
myserial::vehicleControl control;
myserial::vehicleControl control01;
void callback(const myserial::vehicleControl&  c){
     control=c;
     ROS_INFO_STREAM("Write to serial port" << control.mode);
     std_msgs::String msg;
     std::stringstream ss_data;
     ss_data <<control.mode<<control.lidar
       <<control.gamePad_x<<control.gamePad_z<<control.visual_x<<control.visual_z;
      msg.data = ss_data.str();
      ROS_INFO_STREAM("Read: " << msg.data);
      ROS_INFO_STREAM("Read: " << msg);       
     ros_ser.write(msg.data);
 }
void callback00(const myserial::vehicleControl&  c){
     control.lidar=c.lidar;
  
     
 }
void callback01(const myserial::vehicleControl&  c){
     control.visual_x=c.visual_x;
     control.visual_z=c.visual_z;
     
 }
void write_usb(const myserial::vehicleControl&  control){

     ROS_INFO_STREAM("Write to serial port" << control.mode);
     std_msgs::String msg;
     std::stringstream ss_data;
     ss_data <<control.mode<<control.lidar
       <<control.gamePad_x<<control.gamePad_z<<control.visual_x<<control.visual_z;
      msg.data = ss_data.str();
      ROS_INFO_STREAM("Read: " << msg.data);
      ROS_INFO_STREAM("Read: " << msg);       
     ros_ser.write(msg.data);


}
int main (int argc, char** argv){

     ros::init(argc, argv, "my_serial_node");
     ros::NodeHandle n;
      ros::Subscriber command_sub00 = n.subscribe("command00", 1000, callback00);//回调函数,lidar
     ros::Subscriber command_sub01 = n.subscribe("command01", 1000, callback01);//回调函数,visual
      ros::Subscriber command_sub = n.subscribe("command", 1000, callback);//回调函数,gamePad
    
     try
     {
         ros_ser.setPort("/dev/ttyUSB0");//串口号可以修改
         ros_ser.setBaudrate(115200);
         serial::Timeout to = serial::Timeout::simpleTimeout(1000);
         ros_ser.setTimeout(to);
         ros_ser.open();
     }
     catch (serial::IOException& e)
     {
         ROS_ERROR_STREAM("Unable to open port ");
         return -1;
     }
     if(ros_ser.isOpen()){
         ROS_INFO_STREAM("Serial Port opened");
     }else{
         return -1;
     }
     ros::Rate loop_rate(10);
     while(ros::ok()){
         ros::spinOnce();
         if(ros_ser.available()){
            // ROS_INFO_STREAM("Reading from serial port");
             std_msgs::String serial_data;
             
             serial_data.data = ros_ser.read(ros_ser.available());
             ROS_INFO_STREAM("Read: " << serial_data.data);
             
             
         }
         if(control01.mode!=control.mode | control01.lidar!=control.lidar | control01.gamePad_x!=control.gamePad_x | control01.gamePad_z!=control.gamePad_z | control01.visual_x !=control.visual_x | control01.visual_z !=control.visual_z  ){

	     control01=control;
	     write_usb(control01);

        }
         //write_usb();
         loop_rate.sleep();
     }
 }
