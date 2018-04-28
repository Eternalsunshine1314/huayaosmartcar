#include<ros/ros.h> 
#include<iostream> 
#include<cv_bridge/cv_bridge.h> 
#include<sensor_msgs/image_encodings.h> 
#include<image_transport/image_transport.h> 
#include<opencv2/core/core.hpp>
#include<opencv2/highgui/highgui.hpp>
#include<opencv2/imgproc/imgproc.hpp>

static const std::string INPUT = "Input"; 
static const std::string OUTPUT = "Output"; 


class RGB_GRAY
{
private:
    ros::NodeHandle nh_; 
    image_transport::ImageTransport it_; 
    image_transport::Subscriber image_sub_; 
    //image_transport::Publisher image_pub_;
public:
    RGB_GRAY()
      :it_(nh_) 
    {
        image_sub_ = it_.subscribe("/kinect2/qhd/image_color", 1, &RGB_GRAY::convert_callback, this); 
       // image_pub_ = it_.publishe("", 1); 
        
        cv::namedWindow(INPUT);
        cv::namedWindow(OUTPUT);
    }
    ~RGB_GRAY() 
    {
         cv::destroyWindow(INPUT);
         cv::destroyWindow(OUTPUT);
    }
    
    void convert_callback(const sensor_msgs::ImageConstPtr& msg) 
    {
        cv_bridge::CvImagePtr cv_ptr; 
        try
        {
            cv_ptr =  cv_bridge::toCvCopy(msg, sensor_msgs::image_encodings::RGB8); 
        }
        catch(cv_bridge::Exception& e)  
        {
            ROS_ERROR("cv_bridge exception: %s", e.what());
            return;
        }

        image_process(cv_ptr->image); 
    }
    
    void image_process(cv::Mat img) 
    {
       cv::Mat img_out;
       cv::cvtColor(img, img_out, CV_RGB2GRAY);  
       cv::imshow(INPUT, img);
       cv::imshow(OUTPUT, img_out);
       cv::waitKey(5);
    }
};


int main(int argc, char** argv)
{
    ros::init(argc, argv, "RGB");
    RGB_GRAY obj;
    ros::spin();
}
