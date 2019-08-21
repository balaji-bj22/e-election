# eVote
### Idea
  To create a transparent,decentralised application which will allow user to vote from any location using azure blockchain and Xamarin app.
### Pros
*An user friendly interface.*
*Easy to vote and to calculate the results.*
*Will increase the poll percentage as eveyone could vote from their living place.*
## Application Roles
### Election Admin
      The person who conducts election.
### Voter
      One who is eligible to vote.
## Azure Blockchain
  Azure Blockchain service is used for the feature of transparency. The JSON file and the solidity file is deployed in the azure workbench. 
## Azure Active Directory
  Azure AD is used to authenticate the users. All the eligible voters will be added in the azure AD and each will have a username and a password. Azure AD will look after the authentication process.
## Azure Workbench DevKit
  The azure project is cloned and used as the mobile client for android and iOS.
### States  
1)VotingStarted- The election is started and the voters can cast their vote.<br/>
2)VotingEnded- The election is ended and the ElectionAdmin can now announce the result.
### WorkFlow
![alt text](https://github.com/balaji-bj22/e-election/blob/master/Images/Workflow.PNG)
  The ElectionAdmin starts the workflow by creating the contract and also denotes the duration of election.
  After this,the voter can take the Cast your vote action by sending the candidate ID.
  Each voter will be allowed to vote only once.
  After the election duration,the ElectionAdmin can stop the elction and announce the results.
### Future Developments
  This project can be extended for large scale voting scenerio. We can also add the logic app function to send SMS alerts about the election to the users. The mobile UI can be improved to support features like adding voters if the voter name is missing from the voter list.
  
