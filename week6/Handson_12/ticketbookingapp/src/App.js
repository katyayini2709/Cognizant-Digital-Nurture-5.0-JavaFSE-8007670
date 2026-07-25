import React, { useState } from "react";

function LoginButton({ onClick }) {
  return <button onClick={onClick}>Login</button>;
}

function LogoutButton({ onClick }) {
  return <button onClick={onClick}>Logout</button>;
}

function GuestGreeting() {
  return (
    <div>
      <h1>Please sign up.</h1>
      <h3>Flight Details</h3>
      <ul>
        <li>Flight: AI-202</li>
        <li>From: Chennai</li>
        <li>To: Delhi</li>
        <li>Time: 10:00 AM</li>
      </ul>
    </div>
  );
}

function UserGreeting() {
  return (
    <div>
      <h1>Welcome back</h1>
      <h3>You can now book your tickets.</h3>
    </div>
  );
}

function Greeting(props) {
  if (props.isLoggedIn) {
    return <UserGreeting />;
  }
  return <GuestGreeting />;
}

function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  return (
    <div style={{ marginLeft: "180px", marginTop: "80px" }}>
      <Greeting isLoggedIn={isLoggedIn} />

      {isLoggedIn ? (
        <LogoutButton onClick={() => setIsLoggedIn(false)} />
      ) : (
        <LoginButton onClick={() => setIsLoggedIn(true)} />
      )}
    </div>
  );
}

export default App;