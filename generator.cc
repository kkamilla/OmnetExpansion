#include <omnetpp.h>
#include "MACAddress.h"
#include "EtherFrame_m.h"
#include <json/json.h>
class generator : public cSimpleModule
{
private:
int nbPackets, packetCount;
long int numSent,numReceived;
MACAddress address;
MACAddress destaddress;
cMessage*generateMsg;
std::string out;
protected:
virtual void readJson(){
std::ifstream ifile("test.json");
Json::Reader reader;
Json::Value root;
if (ifile != NULL && reader.parse(ifile, root)) {
    const Json::Value arrayDest = root["nodes"];
    for (unsigned int i = 0; i < arrayDest.size(); i++) {
        if (!arrayDest[i].isMember("source"))
            continue;
       // std::string out;
        out = arrayDest[i]["source"].asString();
        std::cout << out << "\n";
    }
}
}
protected:
virtual void initialize()
{
    // Get the MAC Address assigned to this node
     address.setAddress(par("address").stringValue());
     destaddress.setAddress(par("destaddress").stringValue());

       // register the signals
     //  rcvdPkSignal = registerSignal("rcvdPk");
      // drpPkSignal = registerSignal("drpPk");
 nbPackets=par("totalPackets");
 packetCount=0;
 generateMsg=new cMessage("selfMsg");
 numReceived++;
 scheduleAt(simTime()+1,generateMsg);
 numSent=0;
     numReceived=0;
     WATCH(numSent);
     WATCH(numReceived);
}
virtual void updateDisplay()
{
    char buf[40];
    sprintf(buf, "rcvd: %s sent: %ld", out, numSent);
   // sprintf(buf, "source: %ld", out);
    getParentModule()->getDisplayString().setTagArg("t",0,buf);
    EV << "\"updatedisplay\" called\n";
    getParentModule()-> bubble("update display called");


}
virtual void handleMessage(cMessage *msg)
{
    EthernetIIFrame *pkt=new EthernetIIFrame();
    pkt->encapsulate(new cPacket());

    //generate packet and send it out
 EV<<"generated the msg"<<packetCount++;
    packetCount++;
 if(packetCount<nbPackets)
         scheduleAt(simTime()+1,generateMsg);
         pkt->setSrc(address);
         pkt->setDest(destaddress);
         send(pkt,"out");
         numSent++;
         updateDisplay();
}
virtual void finish()
{
 //if (generateMsg!=NULL)
   //  delete generateMsg;
 //drop();
 EV << "Sent:     " << numSent << endl;
    EV << "Received: " << numReceived << endl;

    recordScalar("#sent", numSent);
    recordScalar("#received", numReceived);
}

};
Define_Module(generator);
