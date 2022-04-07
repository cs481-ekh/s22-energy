## 4/7/22 9:00 AM Morning Meeting
#### Group: Jack, Aidan, Keegan, Khaled, Taylor, Victor
<p>
   - Discussed what needed to get done before our meeting with Brian:
      - Upload all utility data and verify it's working with both our backend and frontend
      - Rework frontend utility filtering
      - Upload should display when it's completed
      - Create custom style for the building description cards
      - Fix any bugs with our utility data parsers
   - Tested adding natural gas and small electric data via our csv upload page:
      - Natrual gas uploaded and displayed on map
      - Small electric was incorrectly finding headers and needed to be changed
      - Both did not upload completely
   - Talked about adding SDP server
</p>

## Sprint3 Retrospect
#### Group: Jack, Aidan, Keegan, Khaled, Taylor, Victor
<p>
   This sprint went well! We started it off with a working demo that we presented to our sponsor and
   then spent the rest of the sprint finalizing the backend and adding functionality to the map
   filters, admin login and csv upload. Spring break made it difficult to accomplish as much as I
   would have liked with "3 weeks" but overall we got much of what we needed done. Time to finish strong!
</p>

<p>
   We got most of everything we set out to do done. I think as far as the sprint goes we did very well. 
   We got great work out of everybody. Almost all our tasks are complete. Now we need to iron out 
   the kinks with the project deadline coming up and get ready to polish our final product. 
   Good work!
</p>

<p>
  This sprint went very well for all of us. I was the one who design the sign up page and added some error
  handlings for the texts fields for the signup/login pages. We accomplished almost all the goals for this sprint.
  Time to wrap up our final product. 
  Great work everybody!!
</p>

<p>
   We accomplished all of our goals this sprint and were able to work together effectively and efficiently. We gave a
   demo to Brian at the start of sprint 3 and we all pulled together to make sure our project was ready for a demo.
   If I were to make any criticism, I would say most of the work was done at the start/end of the sprint rather than
   in between, but otherwise excellent work!
</p>

<p>
   This sprint seemed to have a mixture of task that everyone pulled together to complete.  Some group task and some individual task.  
   Everyone did really well communicating and understanding/identifying requirements we need for this sprint.  I do feel like Spring 
   Break set us back a little and took a little bit to get into our stride again.  Overall, I think we did a good job handling our task 
   and the objective of this sprint.  Great work everyone.
</p>


## 4/5/22 4:30 PM Sprint Wrap Up
#### Group: Jack, Aidan, Keegan, Khaled, Taylor, Victor
<p>
   
   - Discussed what we needed to get done before the Sprint finished
   - Talked about how best to implement utility filtering on the front end.
   - Tried out Taylor's start up script for both the server and client.
   - Talked about action items for next Sprint
      - Testing and validation
      - Bug fixing and polishing
      - Small amount of feature addition
   - Talked about adding Senior Design Project Logo to our application
   - Gave team updated environment files since we recently authenticated our back end rest API.
</p>

## 3/29/22 9:00 AM Morning Meeting
#### Group: Jack, Aidan, Keegan, Khaled, Taylor, Victor
<p>
   
   - Planned second half of sprint 3 and assigned tasks to everyone.
   - Talked about best way to handle parsing two different CSV files that are attached to one utility id
      - Decided to create unique types by concatenating the utility id with a string so backend can figure out what parser to invoke
   - Decided we needed more developers working on front end so Aidan decided to move from working on backend tasks to front end tasks.
</p>

## 3/18/22 12:30 PM Sponsor Demo
#### Group: Jack, Aidan, Keegan, Khaled, Taylor, Victor
<p>
   
   - Gave Brian a demo of our current work on the project
   - Discussed future improvements and what still needed to be done.
   - Talked about our data issues.
   - Set up date for another check in and demo.
   
</p>

## 3/17/22 9:00 AM Morning Meeting
#### Group: Jack, Aidan, Keegan, Khaled, Taylor, Victor
<p>
   
   - Talked about progress on demo and any issues that we were having.
   - Talked about issues with postgres and that we needed to update our test database with building coordinates
   - Discussed front end design improvements for demo
      - Make map 100% of viewport
      - Increase height of upload cards
      - Add upload component to a container.
   
    #### Action Items:
      * Make sure all required tasks are finished before demo on Friday.
   
</p>

## 3/16/22 1:30 PM Demo Planning
#### Group: Jack, Aidan, Keegan, Khaled, Taylor, Victor
<p>
   
   - Planned out what needs to be done before our demo to Brian on Friday, March 18th
   - Divied out a task to each developer to get done before Friday so we have a succesful demo.
   - Created a few broad tasks to encapsulate things needed to be done before the demo.
   #### Action Items:
      * Finish backend file uploading, Update client to add ability to upload.
      * Create building controller on backend, have front end able to parse and load building data
      * Create usage controller, have front end able to parse and load usage data.
</p>

## 3/15/22 9:00 AM Morning Meeting
#### Group: Jack, Aidan, Keegan, Khaled, Taylor, Victor
<p>
   
   - Talked about front end design
      - Considered making sidebar more noticeable since it doesn't stand out very well on the page.
      - Talked about removing the whitespace between the map and the sidebar.
      - Considered how we could dynamically generate heatmaps for the buildings to represent energy usage.
         - Possible ideas include using markers with a gradient
         - calculating the size of the circle by sq ft of a building
         - Making the circle size static.
   
   - Talked about getting the login feature up and running.
   - Discussed what needed to be finished on backend before front end work could continue
      - Finish up file upload controller and implement login authentication.
   - Discussed what was the best way to handle file upload on the back end (switch statement vs
   constructor injection vs repository composition)
   - Talked about data issues that we were having and let everyone know that we will only be working
   with the good data and discarding the bad ones.
   - Discussed what needs to be done before Friday for our demo.
   - Started rough sprint planning and reminded everyone to do their sprint retro.
</p>

## Sprint2 Retrospect
#### Group: Jack, Aidan, Keegan, Khaled, Taylor, Victor
<p>
   This sprint went very well. A lot of work has been done to the backend so we 
   we are almost done with that. We also did some progress on the frontend and 
   we are going to shift the work to the frontend for the next sprint. Also we 
   have the first demo on friday, I believe we will some progress to show off. 
   
   I think this sprint went well! We basically have all the csv upload and data 
   insert ready to go. Just need some tests and then we will shift primary work 
   to front end which will go faster when everyone is hands on deck!
   Good progress on front end, need to keep grinding to get the product we want!
   
   This sprint went very well. We were much better about getting the work done
   toward the front/middle instead of the end and we also were able to get a
   log of good work done. We have a demo with our sponsor this friday and I
   think we are going to have some good progress to show off.
   
   I feel good about this sprint. We all proved we were capable of not procrastinating
   and got a good chunk done towards the beginning. I am looking forward to the focus 
   shifting on front end now that we have most of the back end done! 
   
   This sprint covered a lot of times and a lot more was contributed or built off other ideas.
   I think we all did a great interacting with each other and pointing out mistakes.  I do think
   we need to do a better job at having more frequent reviews of project task, so we aren't waiting 
   until the end to get approval.  
   
   This sprint was definetly better than our last one. Everyone kept on track and finished 2-3 tasks per 
   person. We made a lot of headway and got most of what we set out to accomplish done. The backend is 
   "nearly" feature complete and just needs some in depth testing and final touches put on it. The front end 
   has a littlemore work so we will probably be putting a lot of effort towards this next sprint. Overall there 
   was a lot less procrastinating and I am happy with our team dynamic and progress.
   
 </p>

## 3/11/2022 9:00am - Clarification on Data(30 min timeframe)
#### Attendees: Victor, Brian Emtman

<p>
   
   * There were some data points that concerned us.  Three data points showed an excess of $50K dollars in billing.  We weren't sure how to handle this
      *  Brian explained that Idaho power put three parts of the BSU campus on a single charge(3 loops).  That is why the charge is so high and for us to use the cost/kWh used.  Then use the Utility spreadsheet to find the total cost of each builing. 
   
   * Discussed our concerns with the data missing a lot of information. 
      * Brian told us to focus on the big picture and don't worry about the data that can't be validated
      * I suggested to Brian that maybe we identify the buildings that we can and possibly add a way to insert buildings once data becomes available.  
   
   It was a very quick meeting, but I think we were able to come up with some managable solutions. 
   
</p>


## 3/10/2022 9:00am
#### Attendees: Jack, Aidan, Keegan, Khaled, Victor, Taylor

<p>
   
   * Meeting with the professor went well.  
      * We discussed outlineour roles better during the sprints. 
      * We discussed not having our README file updated with information on how to run our application
      * We expressed our concern of the data we will be using for this project.  Data has a lot of errors or missing information.  
   
   * After Professor meeting
      * Discussed issue with data.  May have to us the values that are consistant and accurate.  Possible later feature would be to add buildings in later.  
      * 

   
</p>

## 3/8/2022 9:00am
#### Attendees: Jack, Aidan, Keegan, Khaled, Victor, Taylor

<p>
   
   * Aidan discussed handling csv data errors.  He is working on a error management class, so we can return errors to the user
   * Victor will be setting up a meeting with Brian so he can understand how he gets his data and if there might be ways to clean up the issues we are seeing
   * Keegan/Khaled worked on updating the latitude/Longitude in our Buildings database.  Found that you can't use address to get these values.  So they manually found the lat/long
   * Heroku queries are extremely slow.  Trying to identify how we can speed up this process.  75 queries took almost 3 to 4 seconds per query
   * Front end map reload issue. When refreshing the home page or navigating to it from a different page the React components are loading before the script has finished loading resulting in the map not displaying. We have a temporary solution but a permanent solution needs to be implemented. 
   * Discussed ways to test our front end.  Aidan mentioned JEST, but none of use have every used it, but we may try and work with it.
   * Login Page - Taylor and Jack will work together to get this page going.  
   * Disussed identifying ways to create highlight over building we want to display.  Keegan showed a manual example, which looked great.
   * Decided we are going to use a pin with a colored radius for the heatmap
       instead of mapping out all of the lat/long coordinated for the corners
       of the buildings.
   * Decided we aren't going to put effort into "remember password" logic on
       login page"
   
   #### Action Items:
      * Work on application reload issue
      * Create error management class
      * Login page creation
      * Meet with Brian to discuss data concerns
   
 </p>

## 3/3/2022 9:30am after class meeting
#### Attendees: Jack, Aidan, Keegan, Khaled, Victor

<p>
   
   * Discussed Aidan implementation of JPQL scripts(allows use to access database)
   * Discussed our Main Page layout.  What could we improve on.  
      - Map will be fit-to-page.  
      - Identied what Map and Analytics buttons would do
      - Discussed Admin login page
   * Explained Database additions
      - Add lat/Long to x/y columns in Building database.  Discussed where to get this value from(right click on Bing map will display it)
      - Add a User table with needed column values(first/last name, ID, admin privilage(yes/no))
   * Retrospect was completed
   * Need to complete peer assessment
 </p>

## 3/1/2022 9:30am after class meeting
#### Attendees: Jack, Aidan, Keegan, Khaled, Taylor, Victor

<p>
   
   * Discussed User table we needing added to our database.  Also discussed updating our Buildings table with Long/Lat values.
   * Talked about Keegan's addition of Bing Map to our application.  Looked really good.  We discussed the difference between Google and Bing.  Big difference
   * Discussed having everyone add their retrospects to our Meeting doc.
   * Reminded everyone not to delete their branchs as the Professor mentioned in class
   * Setup everything for Sprint2 and assigned task to everyone.
   * Planning on meeting again on Thursday and making more tasks then.
   
   #### Action Items:
      * Find out if we can get Google API key from BSU
      * Start working on our tasks
      
</p>

## Sprint1 Retrospect
#### Group: Jack, Aidan, Keegan, Khaled, Taylor, Victor

<p>
   We got done with all the tasks that we planned to do, 
   a lot of work was done to get the backend done. We had a serveral meetings during 
   the last two weeks and we had a lot of discussions, the backend might still need more work.  
   
   So we pretty much split into two groups on this sprint. 
   Once for backend and one to start up the front end. 
   I think that this sprint was successful because we achieved all 
   (or most) of the tasks that we set out to complete. We got 
   a good mockup of front end and are on the way to a working 
   backend! Work seemed well distributed and everyone was busy 
   with their tasks.
   
   I think there was a lot of collaboration between all members of our team.  We had several meetings that helped clear 
   up ideas we had.  I do feel like we could have spent some more time on each piece of the sprint.  We have discussed this 
   and next sprint we will spend a lot more time working on our task.  
   

   The sprint went well, we were able to accomplish all the tasks we set out to do. I think some of the tasks could have been tackled in Sprint 0 since 1/4
   of the tasks involved setting up and configuring different aspects of the project. This was mostly due to the fact that we hadn't analyzed the CSV data files
   enough beforehand and figured out how to tackle them. 
   
   Overall, I think everyone did a good job of getting their pieces done, but as others have said a lot of the work was done near the end of the sprint, rather
   than towards the beginning and middle. Given how much we were able to get done in that short period of time I am optimistic about what we can accomplish in
   Sprint 2.

   A good start to the development process for our project. The front end guys
   are doing a great job and the database guys are also doing great work
   getting the data mapped and ready to be useable. I personally didn't do
   enough on this Sprint (Taylor). I volunteered for a task that was originally
   going to be difficult and then we ended up changing our mind on how we
   wanted to do it. This made my task relatively easy, I need to make sure to
   get a heavier work load this next sprint so I can make a bigger impact.
   
   Thought this sprint went well. The way we divided up tasks made sense and we 
   were able to accomplish a fair amount. For this next sprint more work could 
   be done towards the beginning to prevent as much last minute work as possible.
   Along with this I know personally I could have created some additional tasks to
   demonstrate the time I spent researching and learning new technologies. 

</p>
   
## 2/28/2022 12:30pm -Sponser checkin
#### Attendees: Jack, Aidan, Keegan, Khaled, Taylor, Victor, Brian Emtman
<p>
   
   * Discussed spreadsheet/data issues.  Missing building codes and unknown address location(Jerome).  Had to determine what to do with this type of data.
   * Discussed Map API issue and our plan to use Bing Map API.  This could be a problem if BSU wants us to use Google API, would require a complete change to the application
   
   #### Action items:
      
      *  Brian is looking into geting us the needed Building Codes
      *  Brian is also going to see if we can utilize BSU map application.  This is so we don't have complication with having to use Bing Map API
 </p>

## 2/25/2022 10am
#### Attendees: Jack, Aidan, Keegan, Khaled
<p>
   Discussed our progress with current tasks and added additional tasks to complete before Sprint 1 ends.

   #### Action items:
  
    * Khaled working on Postgres wrapper modules (Insert, Delete and Update)
    * Victor working on parsing class
    * Aidan working on database connection class and getting logger injected into multiple modules
    * Jack starting admin login/authentication
    * Taylor/Keegan continue working on current tasks

 </p>

## 2/24/2022 9am
#### Attendees: Jack, Aidan, Keegan, Khaled, Taylor, Victor

<p>
  
   * Google map API requires a credit card number.  We made the decision to move to Bing map API.  They do not require one. 
   * Conversion class method.  Discussed what we would need it to do and they types of measurments it would need to address.  
   * We will have to manually load the database.
   
   #### Action Items:
   
      * Everyone continue working on their task
</p>

## 2/22/2022 9am
#### Attendees: Jack, Aidan, Keegan, Khaled, Taylor, Victor
<p>
  * Reviewed our database tables.  Tried to narrow down the table diagram so it would be more manageable
  * Discussed our energy converstion java class.  How we would handle data conversion both to and from data downloads
  * Disccused adding more libraries/drivers to our project(CSV parsing, postgres)
  
  #### Action items:
  
    * Victor, Aidan and Khaled to work on adding data to database tables
    * Jack and Keegan working on creating first front end page with buttons
    * Taylor working on creating conversion java class
</p>

## 2/19/2022 Database Meeting 2:30pm - 4pm
#### Attendees: Aidan, Khaled, Victor
<p>
  We worked on creating the database schema.  We used sqldbm to generate a graphical representation of our tables. We will be working to add these tables to heroku shortly.  
  </p>

## 2/18/2022 Sponsor Meeting 3:30pm
#### Attendees: Jack, Aidan, Keegan, Khaled, Taylor, Victor, Brian Emtman
<p>
  Meeting Notes:
  
  * Discussed OIT access.  
  * Natural Gas spreadsheet - Brian explained that there is a high volumn number at the bottom of the page.  This number represents a large purchase amount by BSU and we will probably excluded it from our data for now. 
    * This spreadsheet will be in an excel format
  * Linking Tables - We discussed how to link each spreadsheet.  Brian explained that we should use a form of building code and premise number.  
  * Update Page - We discussed how we would wanted to handle missing information.  When new data is present, we will identify the data and have a page that ask if he would like to added.  
  * Steam stretch goal - Brian wanted add a potiential steam option for our page.  For when they decided to added steam to this data
</p>

## 2/15/2022 After Class
#### Attendees: Jack, Aidan, Keegan, Khaled, Taylor, Victor
<p>
  Meeting Notes:
  
  * Looked over the data provided by Brian
  * Discussed our concerns with Energy data we recieved.  Lot of issues
  * Discussed our parts of Sprint0 and addressed any issues
  * Addressed new issue professor commented on in class about the CI
  
  Action items:
  
    1. Review Brian data notes, so we can understand what his data represents
    2. Setup a meeting iwth Brian so we can address our concerns with his data
    3. Discuss Sprint1 on Thursday
    4. Everyone needs to submit their Build, Test, CI assignment
    5. Everyone will add their retrospect for Sprint0 in our Meeting Notes
  
</p>

## Sprint0 Retrospect
#### Group: Jack, Aidan, Keegan, Khaled, Taylor, Victor
<p>
I think the group worked really well together implementing sprint0.
Everyone was able to assist were needed and we did a greate job during our
meeting identifying what our task needed to be and who would handle each task.
I think the only thing I would change would be keeping better meeting
notes/descriptions to be added to our docs.
</p>

<p>
I also think our group did well with sprint 0. We're at kind of an awkard
stage of development where it can be hard to get meaningful and evenyl
distributed tasks for all 6 of us at once, but I foresee this getting better as
we begin true development.
</p>

<p>
The group did a great job implementing sprint0. Everybody was able compelete his task on time, as mentioned the only thing we need to do is to add more notes and descriptions to our docs.
</p>

<p>
We definetely succeeded in our goals this sprint, curious to see how real development will go.
Need to talk with sponsor about how to handle data. Overall I think we are set up to begin dev!
</p>


## 2/10/2022
#### Attendees: Jack, Aidan, Keegan, Khaled, Taylor, Victor
<p>
Meeting notes:
 
* Prepared github for Sprint 0
* Added our issues to github
* Added our milestones to github
* Assigned out issue for sprint 0
* Discussed the project flow and addressed concerns everyone had
* Worked on Build,Test,CI assignment.  
    
Action items:  Everyone is to work on there issues, using Sprint 0 and pull request.  Ask for help if needed.
</p>


## 2/8/2022
#### Attendees: Jack, Aidan, Keegan, Khaled, Taylor, Victor
<p>
Meeting notes:
  
* Finished up project plan diagram
* Created more epic in our github to match our project plan
* Discussed the Jacks' icon he made and we will be using it for this project
* Adjusted out timeline to match stories
* Cleaned up our Risk and Contingency 
* Cleaned up our Diagram discription
    
Action items:  Meeting Thursday during class time to work on Sprint 0
</p>


## 2/6/2022
#### Attendees: Jack, Aidan, Keegan, Khaled, Taylor, Victor
<p>
Meeting notes:
  
* Worked on Build, Test, CI for our React and Springboot setup
* Worked on using professors notes from project setup to clean up our project plan.  Completed this
    
Action items:  Keegan working on Diagram for project plan.  
</p>

## 2/3/2022
#### Attendees: Jack, Aidan, Keegan, Khaled, Taylor, Victor
<p>
  After class meeting to discuss weekend meet up plans.  We decided to meet on Sunday at 4pm to work on our project plan
</p>

## 2/1/2022
#### Attendees: Jack, Aidan, Keegan, Khaled, Taylor, Victor
<p>
  After class meeting, spent the remaining time finishing up our project setup and turned it in
</p>


## 1/31/2022 - Sponsor Meeting
#### Attendees: Jack, Aidan, Keegan, Khaled, Taylor, Victor
<p>
  Meeting went well, spent about 45 minutes talking about expectations for this project, very excited! Here are some things we went over:
  
 * Simple map, 3D campus map overlay might be overkill
 * Ideally would prefer clickable buildings rather than pins (not crucial). Energy data shows up on card with a click.
 * Toggles/filters for electric, gas, geothermal?, solar, historical data (delimits by week/month/year?). (stretch goal: steam)
 * Requested sample data set (He will get .csv and sq. ft. of buildings BY Feb. 8
 * ABSOLUTE(Raw) Energy filter vs. EUI (energy usage intensity --> energy used divided by sq. ft. of building)
 * includes way to graph data like UC berkely energy website (perhaps google dashboard)
 * Potentially autofilling "real time" data from energy client (stretch goal)
 * Future check in meeting planned -> Monday, February 28 @ 12:30
 * Stretch goal: Automated data polling from BSU database for available energy's (alongsige csv upload for other
energies)
  
  Action Items: Finish project plan and get it to sponsor, Plan for future meeting, stay in contact with sponsor for any questions. Recieve .csv from sponsor

</p>


## 1/30/2022
#### Attendees: Jack, Aidan, Keegan, Khaled, Taylor, Victor
<p>
  Spent time discussing what question we should ask in our agenda meeting.  Created an outline of key points we wanted to bring up.  
  We want to also make sure the meeting is recorded so we can refrence it later, if needed.   Our main focus for tomorrow is understanding 
  the data format we will be recieving and showing our map examples of what we think we can do.  Also understanding what his vision might 
  be so we can discuss it.  

  Action Items: 
  Review License: MIT License and GNU General Public License v3.0. Identify which ones would work best

</p>

## 1/27/2022
#### Attendees: Jack, Aidan, Keegan, Khaled, Taylor, Victor
<p>
  Met breifly after class to schedule a time to meet over the weekend.  We plan to meet Sunday 1/30 to setup Sponsor meeting question/adgenda.
  
  Action Items: None
</p>

## 1/25/2022
#### Attendees: Jack, Aidan, Keegan, Khaled, Taylor, Victor
<p>
  Spent the rest of class updating our project draft.  Cleaning up the draft to better align with our goals as a group.  
  Discussing ideas about the project and identifying things we need to get ready for our sponsor meeting that is on Jan 31st.  
  We plan to meet again on Thursday during class to come up with a draft to use when we meet with our sponsor.  
  Finished our draft and submitted it.  
  
  Action Items: None
</p>
