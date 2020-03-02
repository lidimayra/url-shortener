import React from 'react';
import I18n from 'i18n-js';

export const UrlError = () => {
  return (
    <div className="alert alert-danger">
      {I18n.t('home.index.submission-error')}
    </div>
  );
};

export const UrlInfo = ({original, shortened}) => {
  return(
    <div className={"panel panel-default"}>
      <PanelHeading original={original}/>
      <PanelBody shortened={shortened}/>
    </div>
  );
};

const PanelHeading = ({original}) => {
  return(
    <div className="panel-heading">
      <span>{I18n.t('activerecord.attributes.url.original')}</span>
      <div id="original" className="text-muted">{original}</div>
    </div>
  );
};

const PanelBody = ({shortened}) => {
  return(
    <div className="panel-body">
      <span className="panel-info">
        {I18n.t('activerecord.attributes.url.shortened')}
      </span>
      <div id="shortened">
        <a href={shortened}>{window.location.origin}/{shortened}</a>
      </div>
    </div>
  );
}
