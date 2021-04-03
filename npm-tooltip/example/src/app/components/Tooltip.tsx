import React, { useState } from 'react';

interface TooltipProps {
  content: string;
  direction?: 'top' | 'bottom' | 'left' | 'right';
  delay?: number;
  background?: string;
  color?: string;
}
export const Tooltip: React.FC<TooltipProps> = ({
  content,
  direction = 'right',
  delay = 200,
  background = '#333',
  color = '#fff',
  children,
}) => {
  const [show, setShow] = useState(false);

  const showTip = () => {
    setTimeout(() => {
      setShow(true);
    }, delay || 0);
  };

  const hitTip = () => {
    setTimeout(() => {
      setShow(false);
    }, delay || 0);
  };

  const pseudoTooltip = (
    background: string,
    position: 'left' | 'right' | 'top' | 'bottom',
  ) => {
    return (
      <style
        dangerouslySetInnerHTML={{
          __html: `.tooltip-tip.${position}:before { border-${position}-color: ${background};}'`,
        }}
      ></style>
    );
  };

  return (
    <div className="tooltip-wrapper" onMouseEnter={showTip} onMouseLeave={hitTip}>
      <>{children}</>
      {show && (
        <>
          {/* pseudo */}
          {pseudoTooltip(background, direction)}
          <div
            className={`tooltip-tip ${direction}`}
            style={{
              background: `${background}`,
              color: `${color}`,
            }}
          >
            {content}
          </div>
        </>
      )}
    </div>
  );
};

export default Tooltip;
