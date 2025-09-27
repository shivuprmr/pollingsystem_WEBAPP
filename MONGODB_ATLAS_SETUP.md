# MongoDB Atlas Setup Guide for Polling System

## 🚀 Step-by-Step MongoDB Atlas Setup

### Step 1: Create MongoDB Atlas Account
1. Go to [MongoDB Atlas](https://www.mongodb.com/atlas/database)
2. Click **"Try Free"** button
3. Sign up with your email or Google/GitHub account
4. Verify your email address

### Step 2: Create Your First Cluster
1. **Choose Deployment Option:**
   - Select **"Shared"** (Free tier - M0 Sandbox)
   - This gives you 512MB storage for free

2. **Choose Cloud Provider & Region:**
   - **Provider:** AWS, Google Cloud, or Azure (AWS recommended)
   - **Region:** Choose closest to your location for better performance
   - Keep default settings (they're optimized for free tier)

3. **Cluster Configuration:**
   - **Cluster Name:** `polling-system-cluster`
   - **MongoDB Version:** Keep default (latest)
   - Click **"Create Cluster"** (takes 1-3 minutes)

### Step 3: Create Database User
1. **Security Tab:**
   - In left sidebar, click **"Database Access"**
   - Click **"Add New Database User"**

2. **Authentication Method:**
   - Select **"Password"**
   - **Username:** `polling-admin` (or your preferred username)
   - **Password:** Click **"Autogenerate Secure Password"** (SAVE THIS PASSWORD!)
   - Or create your own strong password

3. **Database User Privileges:**
   - Select **"Built-in Role"**
   - Choose **"Atlas Admin"** (for development)
   - Click **"Add User"**

### Step 4: Configure Network Access
1. **Network Access:**
   - In left sidebar, click **"Network Access"**
   - Click **"Add IP Address"**

2. **Add Your IP:**
   - Click **"Add Current IP Address"** (for development)
   - **For Production:** Add specific IP addresses
   - **For Development/Testing:** You can use `0.0.0.0/0` (allows access from anywhere - not recommended for production)
   - Click **"Confirm"**

### Step 5: Get Connection String
1. **Connect to Cluster:**
   - Go to **"Clusters"** (Database → Clusters)
   - Click **"Connect"** button on your cluster

2. **Choose Connection Method:**
   - Select **"Connect your application"**
   - **Driver:** Node.js
   - **Version:** 4.1 or later

3. **Copy Connection String:**
   ```
   mongodb+srv://<username>:<password>@polling-system-cluster.xxxxx.mongodb.net/?retryWrites=true&w=majority
   ```

### Step 6: Create Database and Collections
1. **Browse Collections:**
   - In your cluster, click **"Browse Collections"**
   - Click **"Add My Own Data"**

2. **Create Database:**
   - **Database Name:** `polling-system`
   - **Collection Name:** `users`
   - Click **"Create"**

3. **Add More Collections:**
   - Click **"Create Collection"** button
   - Add these collections:
     - `polls`
     - `votes`
     - `sessions` (optional, for future use)

## 🔧 Configure Your Application

### Step 7: Update Environment Variables
Replace your `.env` file with the MongoDB Atlas connection string:

```env
# Replace with your actual connection string from Atlas
MONGODB_URI=mongodb+srv://polling-admin:YOUR_PASSWORD@polling-system-cluster.xxxxx.mongodb.net/polling-system?retryWrites=true&w=majority
```

### Step 8: Test Connection
Run your backend server to test the connection:
```bash
cd backend
npm run dev
```

Look for: `✅ Connected to MongoDB`

## 🛡️ Security Best Practices

### For Development:
- ✅ Use strong passwords
- ✅ Limit IP access to your development machine
- ✅ Use environment variables for credentials

### For Production:
- ✅ Use specific IP addresses only
- ✅ Create separate user with minimal required permissions
- ✅ Enable additional security features
- ✅ Use connection string with SSL/TLS

## 🔍 Monitoring and Management

### Atlas Dashboard Features:
1. **Real-time Metrics:** Monitor database performance
2. **Query Profiler:** Optimize slow queries
3. **Backup:** Automatic backups (paid feature)
4. **Alerts:** Set up alerts for issues

### Useful Atlas Tools:
- **Data Explorer:** Browse and edit documents
- **Charts:** Create visualizations of your data
- **Realm:** For mobile app synchronization
- **Search:** Full-text search capabilities

## 🚨 Common Issues and Solutions

### Connection Issues:
1. **Wrong IP Address:** Make sure your IP is whitelisted
2. **Incorrect Credentials:** Verify username/password
3. **Network Issues:** Check firewall settings
4. **URL Encoding:** Special characters in password need encoding

### Password with Special Characters:
If your password contains special characters, URL encode them:
- `@` becomes `%40`
- `#` becomes `%23`
- `$` becomes `%24`
- etc.

### Example Encoded Connection String:
```
mongodb+srv://polling-admin:myP%40ssw0rd@polling-system-cluster.xxxxx.mongodb.net/polling-system?retryWrites=true&w=majority
```

## 💡 Atlas Free Tier Limits
- **Storage:** 512 MB
- **RAM:** Shared
- **Connections:** 500 maximum
- **Perfect for development and small applications**

## 🎯 Next Steps After Setup
1. Test connection with your backend
2. Create sample data for testing
3. Set up data validation rules
4. Configure indexes for better performance
5. Set up monitoring and alerts

---

## 📞 Need Help?
- MongoDB Atlas Documentation: https://docs.atlas.mongodb.com/
- MongoDB Community Forums: https://www.mongodb.com/community/forums/
- Stack Overflow: Tag your questions with `mongodb-atlas`