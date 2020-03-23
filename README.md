
Thank you for checking out my coinApi.  I will leave some notes below on how to access the routes and functionality of the api!  I have also implemented notes throughout the code if you would like to see shorter notes on what each method's purpose is.  Please be advised that some request requre the use postman, like POST and DELETE request!  Thanks and I appreciate you taking the time to check this out! :)

### Step 1: Coins

In this part I was instructed to create a coin resourse.  I created migrations/models/controller for that resource.  

Coin database 

- For the coin database I used postgres and added the columns name, value, timestamps(updates/created at), and eventually added a count option.  Instead of scanning for just the one object coin I made it where, for example 
     a penny object is worth 1 and has a name "penny" 
     but instead of having a lot of those objects in the data base as users deposit/withdraw I just added a count for that certain users "coins"
 
Coin model

- For the coin model I added some validations.
- I also added a few methods
    methods
        Coin#total
            gives the total available balance by taking the values and 'count' of all coins and returning it in dollar format
        Coin#minusCoin
            subtracts 1 from a given coins count (since the machine can only take one coin in and out at a time)
            saves to db!
        Coin#refillCoin
            Does the opposite.  Adds a coin by 1 instead.
            again saves to db!

Coins controller

- Coin#index  GET /coins
    shows all coins

- Coin#show  GET /coins/:id
    shows coin of the given id

- Coin#create  POST /coins 
    you will need to send params of coins[name] = "this" , coin[value] = this
  creates a brand new coin for the system
    #postman

- Coin#destroy DELETE /coins/:id
    removes coin from system 
    #postman

- Coin#update PATCH /coins/:id
    updates a name/count/value of coin need to provided param as coin[name] and coin[value]
    #postman

- Coin#available GET /total
    -gets the total balance of all coins in system in dollars




### Step 2/3/4: Deposits/Withdrawals/Email

    Transactions database

- I implemented a database with the values 
    coin_id - to include the coin that is part of the transaction
    user_id - to connect the user whos coins they are
    transaction_type - track if its a withdrawal or deposit
    timestamps - to track when the transaction was made 

    I also added a few validations/associations to the transaction model
    
 Transactions Controller 

- #index  GET /transactions
    shows all transactions

- #create POST /transactions
    pleaser enter following params in postman 
    transaction[coin_id], transaction[user_id], transaction[transaction_type]
    creates a new transaction object 

- #show GET /transactions/:id
    shows a transaction based on id given

- #withdrawals GET /withdrawals
    shows only withdrawal transactions

- #deposits GET /deposits
    shows all deposit transactions

- #withdraw GET /withdraw/:coin_id    transaction[:coin_id] transaction[:user_id]
    -subtracts from the count of a coin if balance is greater than zero 
    -sends emails to all admin accounts if coins are less than 5 in count
    - creates a new withdrawal transaction object and save it 
    ####note_to_self transaction not saving because user technically doesnt exist 

- #deposit GET /deposit/:coin_id   transaction[:coin_id] transaction[:user_id]
    - same as above except no emails and for adding more to the coint of coins 
    ####note_to_self transaction not saving because user technically doesnt exist 

- #userTransactions GET /usertransactions/:user_id
    -gets transactions by user

- #transactionTime? Get /transactions/:id/time
    -gives the time the transactions took place 


!AUTHENTICATION!

- I have also implemented my ownt authentication system which requires an email address and password.  Password is not stored by encrypted via BCRYPT and stored as a digest.  Access requires email login/password and an api key.  First step usually would be to create a user account.

    Users Controller 
        #create POST /users
            params required:
                user[:email] user[:password] user[:account_type] 
                    note: key will be assigned to a new user automatically if not provided
                    but for testing purposes please enter 'admin' as the user[:account_type]
                    creates new account send api_key
    
    Sessions Controller
        #create POST /signin 
            params required:
                session[:email] session[:password] session[:api_key]
            a new session that does verification of email, password, and api key that was sent in the email.
        #destroy
            signs user out but since this a json api might not be able to do it
        
        For the purpose of seeing the functionality please use postman.  This api is also uploaded to heroku.  I have commented out my "before_action authenticate" option on my controllers as without a front end it will be hard to test the other functionality.  So at the moment you can view it without any authentication.  I have also seeded the database with test coins and transactions which you can view by following the functionality above.  Below I will provie a basic suggestion for you on how to test functionality.  

        1.  Get your api_key by through postman to see if that functionality works by going to POST '/users'  please provide params as such params[:email] , params[password], params[account_type] you can set account type to admin or leave it be if you'd like

        2.check sign in functionality by going to POST '/signin'  (POSTMAN! :)
            Please provide params as such, params[:email], params[:password], paramas[:api_key]

        3. after this feel free to go ahead and check out the rest of the functionality as stated in the controllers.  Something do depend on being logged in like the user_id in transactions might be null which will cause the transaction not to save.  This is the reason I have included test items in the database.  Thanks!  You can use the link: https://coinapp1.herokuapp.com/ 

        Lastly, thank you for taking the time to read this and looking at my work!  If you have any questions please feel free to email me at syedm199343@gmail.com.  





## Submission
When you are ready to submit this challenge, please email elliott@mortgagehippo.com with the following included:

* The URL of the deployed site
* The URL of the GitHub Repo
* Any additional notes you'd like to include





