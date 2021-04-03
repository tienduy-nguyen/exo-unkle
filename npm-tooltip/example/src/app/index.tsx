import React from 'react';
import { Tooltip } from 'td-react-tooltip';

export function App() {
  return (
    <div className="main">
      <div className="container small mt-5">
        <h1 className="text-center">React tooltips demo</h1>
        <div className="d-flex justify-between mt-2">
          <Tooltip
            content="Hi, I'm a tooltip on top"
            direction="top"
            delay={0}
            background="#27ae60"
          >
            <button className="btn">Tooltip on top</button>
          </Tooltip>
          <Tooltip
            content="Hi, I'm a tooltip on bottom"
            direction="bottom"
            delay={0}
            background="#d35400"
          >
            <button className="btn">Tooltip on bottom</button>
          </Tooltip>
          <Tooltip
            content="Hi, I'm a tooltip on left"
            direction="left"
            delay={0}
            background="#f39c12"
          >
            <button className="btn">Tooltip on left</button>
          </Tooltip>
          <Tooltip content="Hi, I'm a tooltip on right" direction="right" delay={0}>
            <button className="btn">Tooltip on right</button>
          </Tooltip>
        </div>
      </div>
    </div>
  );
}

export default App;
