# NPM React Tooltips

Lightweight React tooltips, full TypeScript support

## Quick start

- Installation: 
  ```ts
  $ yarn install td-react-tooltip
  # or
  $ npm i td-react-tooltip
  ```

- How to use
  ```ts
  import Tooltip from 'td-react-tooltip';

  export function App = ()=>{
    return(
      <>
        <div className="App">
          <Tooltip
            content="Hi, I'm a tooltip on top"
            direction="top"
            delay={0}
            background="#27ae60"
          >
            <button className="btn">Tooltip on top</button>
          </Tooltip>
        </div>

      </>
    )
  }
  ```

- Options of tooltips
  - content (*): Text display for tooltip
  - direction (*): position of tooltip box
  - delay: Time delay en millisecond before displaying (default 0 ms)
  - background: background of tooltip box (default black - #333)
  - color: color of text, default white

- Project example: Check to Vite.js project in [github repo](https://tienduy-nguyen/exo-unkle/npm-tooltip/example)