import React from 'react';

export const pseudoTooltip = (
  background: string,
  position: 'left' | 'right' | 'top' | 'bottom',
) => {
  // const upper = position[0].toUpperCase() + position.substr(1);
  return (
    <style
      dangerouslySetInnerHTML={{
        __html: `.tooltip-tip.${position}::before {borderTopColor: ${background}}'`,
      }}
    ></style>
  );
};
