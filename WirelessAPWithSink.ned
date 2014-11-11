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

import inet.base.NotificationBoard;
import inet.base.Sink;
import inet.linklayer.ieee80211.Ieee80211Nic;
import inet.mobility.static.StationaryMobility;


//
// Well, this models a 802.11 Access Point with a Sink.
//
module WirelessAPWithSink
{
    parameters:
        @node();
        @labels(node);
        @display("i=device/accesspoint");
    gates:
        input radioIn @directIn;
    submodules:
        sink: Sink {
            parameters:
                @display("p=169,124");
        }
        wlan: Ieee80211Nic {
            parameters:
                @display("p=89,225;q=queue");
                mgmtType = default("Ieee80211MgmtAPSimplified");
               
        }
        notificationBoard: NotificationBoard {
            parameters:
                @display("p=78,60");
        }
        mobility: StationaryMobility {
            parameters:
                @display("p=71,121");
        }
    connections allowunconnected:
        radioIn --> { @display("m=s"); } --> wlan.radioIn;
        wlan.upperLayerOut --> sink.in++;
}

