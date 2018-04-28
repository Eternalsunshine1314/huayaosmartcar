// Auto-generated. Do not edit!

// (in-package myserial.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class vehicleControl {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.mode = null;
      this.lidar = null;
      this.gamePad_x = null;
      this.gamePad_z = null;
      this.visual_x = null;
      this.visual_z = null;
    }
    else {
      if (initObj.hasOwnProperty('mode')) {
        this.mode = initObj.mode
      }
      else {
        this.mode = 0;
      }
      if (initObj.hasOwnProperty('lidar')) {
        this.lidar = initObj.lidar
      }
      else {
        this.lidar = 0;
      }
      if (initObj.hasOwnProperty('gamePad_x')) {
        this.gamePad_x = initObj.gamePad_x
      }
      else {
        this.gamePad_x = 0;
      }
      if (initObj.hasOwnProperty('gamePad_z')) {
        this.gamePad_z = initObj.gamePad_z
      }
      else {
        this.gamePad_z = 0;
      }
      if (initObj.hasOwnProperty('visual_x')) {
        this.visual_x = initObj.visual_x
      }
      else {
        this.visual_x = 0;
      }
      if (initObj.hasOwnProperty('visual_z')) {
        this.visual_z = initObj.visual_z
      }
      else {
        this.visual_z = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type vehicleControl
    // Serialize message field [mode]
    bufferOffset = _serializer.int64(obj.mode, buffer, bufferOffset);
    // Serialize message field [lidar]
    bufferOffset = _serializer.int64(obj.lidar, buffer, bufferOffset);
    // Serialize message field [gamePad_x]
    bufferOffset = _serializer.int64(obj.gamePad_x, buffer, bufferOffset);
    // Serialize message field [gamePad_z]
    bufferOffset = _serializer.int64(obj.gamePad_z, buffer, bufferOffset);
    // Serialize message field [visual_x]
    bufferOffset = _serializer.int64(obj.visual_x, buffer, bufferOffset);
    // Serialize message field [visual_z]
    bufferOffset = _serializer.int64(obj.visual_z, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type vehicleControl
    let len;
    let data = new vehicleControl(null);
    // Deserialize message field [mode]
    data.mode = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [lidar]
    data.lidar = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [gamePad_x]
    data.gamePad_x = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [gamePad_z]
    data.gamePad_z = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [visual_x]
    data.visual_x = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [visual_z]
    data.visual_z = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 48;
  }

  static datatype() {
    // Returns string type for a message object
    return 'myserial/vehicleControl';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0b93a3ac7d139c45be24cc985db5ca1b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int64 mode
    int64 lidar
    int64 gamePad_x
    int64 gamePad_z
    int64 visual_x
    int64 visual_z  
    
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new vehicleControl(null);
    if (msg.mode !== undefined) {
      resolved.mode = msg.mode;
    }
    else {
      resolved.mode = 0
    }

    if (msg.lidar !== undefined) {
      resolved.lidar = msg.lidar;
    }
    else {
      resolved.lidar = 0
    }

    if (msg.gamePad_x !== undefined) {
      resolved.gamePad_x = msg.gamePad_x;
    }
    else {
      resolved.gamePad_x = 0
    }

    if (msg.gamePad_z !== undefined) {
      resolved.gamePad_z = msg.gamePad_z;
    }
    else {
      resolved.gamePad_z = 0
    }

    if (msg.visual_x !== undefined) {
      resolved.visual_x = msg.visual_x;
    }
    else {
      resolved.visual_x = 0
    }

    if (msg.visual_z !== undefined) {
      resolved.visual_z = msg.visual_z;
    }
    else {
      resolved.visual_z = 0
    }

    return resolved;
    }
};

module.exports = vehicleControl;
