import "./App.css";
import Book from "./Book";
import Blog from "./Blog";
import Course from "./Course";

function App() {
  return (
    <div className="container">
      <Course />
      <Book />
      <Blog />
    </div>
  );
}

export default App;