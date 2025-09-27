// API Test Script for Polling System
// Run this to test the backend API endpoints

const API_BASE_URL = 'http://localhost:3001/api';

// Test user data
const testUser = {
  email: 'test@example.com',
  password: 'TestUser123',
  firstName: 'Test',
  lastName: 'User',
  role: 'student'
};

const adminUser = {
  email: 'admin@polling.com',
  password: 'Admin123',
  firstName: 'Admin',
  lastName: 'User',
  role: 'admin'
};

// Test poll data
const testPoll = {
  title: 'Favorite Programming Language',
  description: 'Which programming language do you prefer for web development?',
  type: 'single-choice',
  options: [
    { text: 'JavaScript' },
    { text: 'Python' },
    { text: 'TypeScript' },
    { text: 'Java' }
  ],
  allowAnonymous: false,
  isPublic: true,
  expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000) // 7 days from now
};

// Helper function to make API requests
async function apiRequest(endpoint, method = 'GET', data = null, token = null) {
  const url = `${API_BASE_URL}${endpoint}`;
  const headers = {
    'Content-Type': 'application/json',
    ...(token && { 'Authorization': `Bearer ${token}` })
  };

  const config = {
    method,
    headers,
    ...(data && { body: JSON.stringify(data) })
  };

  try {
    console.log(`🔄 ${method} ${endpoint}`);
    const response = await fetch(url, config);
    const result = await response.json();
    
    if (response.ok) {
      console.log(`✅ ${method} ${endpoint} - Success`);
      return { success: true, data: result };
    } else {
      console.log(`❌ ${method} ${endpoint} - Error:`, result.message || result.error);
      return { success: false, error: result };
    }
  } catch (error) {
    console.log(`💥 ${method} ${endpoint} - Network Error:`, error.message);
    return { success: false, error: error.message };
  }
}

// Test functions
async function testHealthCheck() {
  console.log('\n🏥 Testing Health Check...');
  return await apiRequest('/health');
}

async function testUserRegistration() {
  console.log('\n👤 Testing User Registration...');
  const result = await apiRequest('/auth/register', 'POST', testUser);
  return result;
}

async function testAdminRegistration() {
  console.log('\n👑 Testing Admin Registration...');
  const result = await apiRequest('/auth/register', 'POST', adminUser);
  return result;
}

async function testUserLogin() {
  console.log('\n🔑 Testing User Login...');
  const result = await apiRequest('/auth/login', 'POST', {
    email: testUser.email,
    password: testUser.password
  });
  return result;
}

async function testAdminLogin() {
  console.log('\n🔑 Testing Admin Login...');
  const result = await apiRequest('/auth/login', 'POST', {
    email: adminUser.email,
    password: adminUser.password
  });
  return result;
}

async function testCreatePoll(token) {
  console.log('\n📝 Testing Poll Creation...');
  const result = await apiRequest('/polls', 'POST', testPoll, token);
  return result;
}

async function testGetPolls() {
  console.log('\n📋 Testing Get All Polls...');
  const result = await apiRequest('/polls');
  return result;
}

async function testVoting(pollId, optionId, token) {
  console.log('\n🗳️ Testing Voting...');
  const result = await apiRequest('/votes', 'POST', {
    poll: pollId,
    options: [optionId]
  }, token);
  return result;
}

// Main test function
async function runAllTests() {
  console.log('🚀 Starting API Tests for Polling System');
  console.log('===============================================\n');

  let userToken = null;
  let adminToken = null;
  let pollId = null;
  let optionId = null;

  // Test 1: Health Check
  await testHealthCheck();

  // Test 2: User Registration
  const userRegResult = await testUserRegistration();
  
  // Test 3: Admin Registration
  const adminRegResult = await testAdminRegistration();

  // Test 4: User Login
  const userLoginResult = await testUserLogin();
  if (userLoginResult.success && userLoginResult.data.token) {
    userToken = userLoginResult.data.token;
    console.log('🔑 User token obtained');
  }

  // Test 5: Admin Login
  const adminLoginResult = await testAdminLogin();
  if (adminLoginResult.success && adminLoginResult.data.token) {
    adminToken = adminLoginResult.data.token;
    console.log('🔑 Admin token obtained');
  }

  // Test 6: Create Poll (Admin only)
  if (adminToken) {
    const createPollResult = await testCreatePoll(adminToken);
    if (createPollResult.success && createPollResult.data.poll) {
      pollId = createPollResult.data.poll._id;
      if (createPollResult.data.poll.options && createPollResult.data.poll.options.length > 0) {
        optionId = createPollResult.data.poll.options[0].id;
      }
      console.log('📝 Poll created with ID:', pollId);
    }
  } else {
    console.log('⚠️ Skipping poll creation - no admin token');
  }

  // Test 7: Get All Polls
  await testGetPolls();

  // Test 8: Vote on Poll
  if (userToken && pollId && optionId) {
    await testVoting(pollId, optionId, userToken);
  } else {
    console.log('⚠️ Skipping voting test - missing requirements');
  }

  console.log('\n===============================================');
  console.log('🎉 API Tests Complete!');
  console.log('Check the results above for any issues.');
  
  return {
    userToken,
    adminToken,
    pollId,
    optionId,
    testResults: {
      userRegistration: userRegResult.success,
      adminRegistration: adminRegResult.success,
      userLogin: userLoginResult.success,
      adminLogin: adminLoginResult.success
    }
  };
}

// Export for use in browser or Node.js
if (typeof window !== 'undefined') {
  // Browser environment
  window.runAPITests = runAllTests;
  window.apiRequest = apiRequest;
  console.log('🌐 API test functions loaded in browser');
  console.log('Run: runAPITests() to start testing');
} else if (typeof module !== 'undefined' && module.exports) {
  // Node.js environment
  module.exports = {
    runAllTests,
    apiRequest,
    testUser,
    adminUser,
    testPoll
  };
}

// Auto-run if this file is executed directly
if (typeof require !== 'undefined' && require.main === module) {
  runAllTests().catch(console.error);
}