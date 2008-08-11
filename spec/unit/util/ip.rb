#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/../../spec_helper'

require 'facter/util/ip'

describe Facter::IPAddress do

    it "should return a list of interfaces" do
       Facter::IPAddress.should respond_to(:get_interfaces)
    end

    it "should return an empty list of interfaces on an unknown kernel" do
        Facter.stubs(:value).returns("UnknownKernel")
        assert_equal [], Facter::IPAddress.get_interfaces()
    end

    it "should return a list with a single interface on Linux with a single interface" do
        linux_ifconfig = <<EOS
eth0      Link encap:Ethernet  HWaddr 00:0c:29:52:15:e9  
          inet addr:172.16.15.133  Bcast:172.16.15.255  Mask:255.255.255.0
          inet6 addr: fe80::20c:29ff:fe52:15e9/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:173 errors:173 dropped:0 overruns:0 frame:0
          TX packets:208 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:40970 (40.0 KB)  TX bytes:24760 (24.1 KB)
          Interrupt:16 Base address:0x2024 

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:1630 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1630 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:81500 (79.5 KB)  TX bytes:81500 (79.5 KB)
EOS
        Facter::IPAddress.stubs(:get_all_interface_output).returns(linux_ifconfig)
        assert_equal ["eth0"], Facter::IPAddress.get_interfaces()
    end

    it "should return a value for a specific interface" do
       Facter::IPAddress.should respond_to(:get_interface_value)
    end

end

