import React from 'react';
import I18n from 'i18n-js';

const LanguageSelector = () => {
  return (
    <span>
      <LanguageLink locale="en" name="english"/>    <span>| </span>
      <LanguageLink locale="pt" name="portuguese"/> <span>| </span>
      <LanguageLink locale="de" name="german"/>
    </span>
  );
};

const LanguageLink = ({locale, name}) => {
  return(
    <a href={`/?locale=${locale}`}>{I18n.t(`home.index.${name}`)}</a>
  );
};

export default LanguageSelector;

