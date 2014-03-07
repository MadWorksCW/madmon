require 'spec_helper'

describe PingWatch do 
  let(:output) {
      <<-eos
PING www.google.com (74.125.225.116): 56 data bytes
64 bytes from 74.125.225.116: icmp_seq=0 ttl=54 time=19.135 ms

--- www.google.com ping statistics ---
1 packets transmitted, 1 packets received, 0.0% packet loss
round-trip min/avg/max/stddev = 19.135/19.135/19.135/0.000 ms
eos
  }

  context "#parse_ping_to_ms" do  
    it "Should parse the time out of a ping result" do
      expect(PingWatch.parse_ping_to_ms(output)).to eq 19.135
    end
  end

  context "#tick" do 
    let(:ping_watch) { PingWatch.create(config: {host: "www.google.com"}) }
    it "should create a new datapoint" do
      expect { ping_watch.tick }.to change{Datapoint.count}.by(1)
    end
    it "should set the value of the datapoint to the number of miliseconds" do 
      ping_watch.stub(:ping_output).and_return(output)
      datapoint = ping_watch.tick
      expect(datapoint.value).to eq 19.135
    end
  end
end