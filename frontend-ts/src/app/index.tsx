import React from 'react';

export function App() {
  return (
    <div className="main">
      <div className="container small mt-5">
        <h1 className="text-center">React tooltips demo</h1>
        <div className="d-flex justify-between mt-2">
          <button className="btn">Tooltip on top</button>
          <button className="btn">Tooltip on bottom</button>
          <button className="btn">Tooltip on left</button>
          <button className="btn">Tooltip on right</button>
        </div>
      </div>
    </div>
  );
}

export default App;
