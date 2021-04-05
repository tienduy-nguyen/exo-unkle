import React from 'react';

export const pseudoTooltip = (
  background: string,
  position: 'left' | 'right' | 'top' | 'bottom'
) => {
  return (
    <style
      dangerouslySetInnerHTML={{
        __html: `.tooltip-tip.${position}:before { border-${position}-color: ${background};}'`,
      }}
    ></style>
  );
};
