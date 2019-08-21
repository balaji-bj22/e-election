pragma solidity >=0.4.22 <0.6.0;
contract Election {
    enum StateType {VotingStarted,VotingEnded}
    address electionAdmin;
    string public EndTime;
    uint public count;
    uint public WinnerId;
    string public WinnerName;
    int public WinnerVoteCount;
    //struct which represents the candidates
    struct Candidate
    {        
        uint candidateId;
        string candidateName;
        int voteCount;
    }
    mapping(uint=>Candidate)public candidatesRef;
    mapping(address=>bool)public votersRef;
    StateType public State;
    function addCandidate(string memory name) public
    {
        if(msg.sender != electionAdmin )
        {
            revert();
        }
        count++;
        candidatesRef[count]=Candidate(count,name,0);
    }
    constructor(uint duration) public{
        duration=duration*1 hours;
        electionAdmin = msg.sender;
        //to find the election end time
        uint temp=block.timestamp+duration;
        uint t=24*60*60;
        temp=temp+300;
        uint day=temp/t;
	    uint rem=temp%t;
	    uint hr=rem/3600;
	    rem=rem%3600;
	    uint minu=rem%60;
        uint d=1;
        uint m=1;
        uint year=1970;
        while(day!=0)
        {
            ++d;
            if(m==1 || m==3 || m==5 || m==7 || m==8 || m==10 || m==12)
            {
                if(d==32)
                {
                    if(m==12)
	                {               
                        ++year;
		                m=1;
		                d=1;
                    }
                    else
	                {
                        ++m;
		                d=1;
	                }
                }
            }
            else if(m==4 || m==6 || m==9 || m==11)
            {
                if(d==31)
                {
                    m++;
    	            d=1;
                }
            }
            else if(m==2)
            {
                if((year%400==0 )|| (year%100!=0 && year%4==0))
                {
                    if(d==30)
                    {
                        ++m;
		                d=1;
                    }
                }
                else
                {
                    if(d==29)
	                {
                        ++m;
		                d=1;
	                }
                }
            }
        --day;
    }
    bytes memory s=new bytes(16);
    if(d<10)
    {
	    s[0]='0';
	    s[1]=byte(48+d);

    }
    else
    {
	    s[0]=byte(48+(d/10));
	    s[1]=byte(48+(d%10));
    }
    s[2]='/';
    if(m<10)
    {
	    s[3]='0';
	    s[4]=byte(48+m);

    }
    else
    {
	    s[3]=byte(48+(m/10));
	    s[4]=byte(48+(m%10));
    }
    s[5]='/';
    s[6]=byte(48+(year/1000));
    s[7]=byte(48+(year/100)%10);
    s[8]=byte(48+(year/10)%10);
    s[9]=byte(48+(year%10));
    s[10]=' ';
    if(hr<10)
    {
	    s[11]='0';
	    s[12]=byte(48+hr);
    }
    else
    {
	    s[11]=byte(48+(hr/10));
	    s[12]=byte(48+(hr%10));

    }
    s[13]=':';
    if(minu<10)
    {
	    s[14]='0';
	    s[15]=byte(48+minu);
    }
    else
    {
	    s[14]=byte(48+(minu/10));
	    s[15]=byte(48+(minu%10));

    }
        EndTime=string(s);
        State=StateType.VotingStarted;
        WinnerId=0;
        WinnerName="TBA";
        WinnerVoteCount=-1;
        //adding the candidates
        addCandidate("Donald Trump");
        addCandidate("Hilary Clinton");
        addCandidate("Barack Obama");
        addCandidate("George Washington");
        addCandidate("NOTA");
    }
    
    function vote(uint cid) public
    {
        require(!votersRef[msg.sender]);
        if(State == StateType.VotingEnded)
        {
            revert();
        }
        votersRef[msg.sender]=true;
        candidatesRef[cid].voteCount++;   
        
    }
	function stopElection()public
	{
		if(msg.sender != electionAdmin)
		{
			revert();
		}
		State=StateType.VotingEnded;
	}
    function resultAnnouncement()public
    {
        if(State != StateType.VotingEnded)
        {
            revert();
        }
        int flag=0; //flag to check if the election is tied or not
        WinnerId=1;
        WinnerName=candidatesRef[1].candidateName;
        WinnerVoteCount=candidatesRef[1].voteCount;
        for(uint i=2;candidatesRef[i].candidateId != 0;i++)
        {
                if(candidatesRef[i].voteCount>WinnerVoteCount && candidatesRef[i].candidateId != 5)
                {
                    WinnerId=i;
                    WinnerName=candidatesRef[i].candidateName;
                    WinnerVoteCount=candidatesRef[i].voteCount;
                    flag=0;
                }
                else if(candidatesRef[i].voteCount==WinnerVoteCount)
                {
                    flag=1;
                }
        }
        if(flag==1)
        {
            WinnerId=0;
            WinnerName="TIED";
            WinnerVoteCount=-1;
        }

    }  
}