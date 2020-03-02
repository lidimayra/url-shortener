import React from 'react';
import I18n from 'i18n-js';

const LanguageSelector = () => {
  return (
    <div className="row">
      <div className="col-md-6 col-md-offset-3">
        <LanguageLink locale="en" name="english"/>    <span>| </span>
        <LanguageLink locale="pt" name="portuguese"/> <span>| </span>
        <LanguageLink locale="de" name="german"/>
      </div>
    </div>
  );
};

const LanguageLink = ({locale, name}) => {
  return(
    <a href={`/?locale=${locale}`}>{I18n.t(`home.index.${name}`)}</a>
  );
};

export default LanguageSelector;

