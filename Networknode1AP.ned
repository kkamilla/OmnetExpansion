//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package packetgenerator;
import inet.linklayer.ieee80211.Ieee80211Nic;
import inet.mobility.static.StationaryMobility;
import inet.world.radio.ChannelControl;

network Networknode1AP
{
    parameters:
       // int numCli;
      //  @display("b=297,203");
    submodules:
        cliHost: node1{
            parameters:
                @display("r=,,#707070");
        }
        cliHost1: node1 {
            parameters:
                @display("r=,,#707070");
        }
        cliHost2: node1 {
            parameters:
                @display("r=,,#707070");
        }
        cliHost3: node1 {
            parameters:
                @display("r=,,#707070");
        }
        ap: WirelessAPWithSink {
            parameters:
                @display("p=200,200;r=,,#707070");
        }
         ap1: WirelessAPWithSink {
            parameters:
                @display("p=200,200;r=,,#707070");
        }
        channelControl: ChannelControl {
            parameters:
                @display("p=61,46");
        }
}


