import office from "./image.png";

function App() {

  const element = "Office Space";

  const offices = [
    {
      Name: "DBS",
      Rent: 50000,
      Address: "Chennai"
    },
    {
      Name: "Regus",
      Rent: 70000,
      Address: "Hyderabad"
    },
    {
      Name: "WeWork",
      Rent: 55000,
      Address: "Bangalore"
    }
  ];

  return (
    <div style={{ marginLeft: "120px" }}>
      <h1>{element}, at Affordable Range</h1>

      {offices.map((item, index) => (

        <div key={index}>

          <img
            src={office}
            width="25%"
            height="25%"
            alt="Office Space"
          />

          <h1>Name: {item.Name}</h1>

          <h3
            style={{
              color: item.Rent <= 60000 ? "red" : "green"
            }}
          >
            Rent: Rs. {item.Rent}
          </h3>

          <h3>Address: {item.Address}</h3>

          <br />
        </div>

      ))}
    </div>
  );
}

export default App;