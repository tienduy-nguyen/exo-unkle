import React, { useState } from 'react';
import { pseudoTooltip } from './PseudoTooltip';
import './style.scss';

interface TooltipProps {
  content: string;
  direction?: 'top' | 'bottom' | 'left' | 'right';
  delay?: number;
  background?: string;
  color?: string;
  fontSize?: string;
}
export const Tooltip: React.FC<TooltipProps> = ({
  content,
  direction = 'right',
  delay = 0,
  background = '#333',
  color = '#fff',
  fontSize = '1rem',
  children,
}) => {
  const [show, setShow] = useState(false);

  const showTip = () => {
    setTimeout(() => {
      setShow(true);
    }, delay);
  };

  const hitTip = () => {
    setTimeout(() => {
      setShow(false);
    }, delay);
  };

  const style = {
    background: `${background}`,
    color: `${color}`,
    fontSize: `${fontSize}`,
  };

  return (
    <div
      className='tooltip-wrapper'
      onMouseEnter={showTip}
      onMouseLeave={hitTip}
    >
      <>{children}</>
      {show && (
        <>
          {/* pseudo */}
          {pseudoTooltip(background, direction)}
          <div className={`tooltip-tip ${direction}`} style={style}>
            {content}
          </div>
        </>
      )}
    </div>
  );
};

export default Tooltip;
