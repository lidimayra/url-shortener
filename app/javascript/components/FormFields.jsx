import React from 'react';
import I18n from 'i18n-js';

const FormFields = () => {
  return (
    <span>
      <UrlField/>
      <SubmitButton/>
    </span>
  );
};

const UrlField = () => {
  return(
    <div className="form-group">
      <label htmlFor="url_original"/>
        <strong>{I18n.t('home.index.enter-url')}</strong>
      <input className="form-control" type="text" id="url_original"
      name="url[original]" placeholder={I18n.t('home.index.example-url')}/>
    </div>
  );
};

const SubmitButton = () => {
  return(
    <div className="form-group">
      <input type="submit" value={I18n.t('home.index.submit')} className="btn btn-primary"/>
    </div>
  );
}

export default FormFields;
