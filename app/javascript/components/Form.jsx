import React from "react";
import PropTypes from "prop-types";
import axios from 'axios';
import I18n from 'i18n-js';

import FormFields from './FormFields';
import LanguageSelector from './LanguageSelector';
import {UrlError, UrlInfo} from './UrlInfoSection';

class Form extends React.Component {
  constructor(props) {
    I18n.locale = props.locale || "en";

    super(props);
    this.state = {
      originalUrl: "",
      shortenedUrl: "",
      urlError: false
    }

    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit(e) {
    e.preventDefault();

    axios
      .post('/urls', { url: { original: e.target[0].value } })
      .then((response) => {
        this.setState(state =>  ({
          originalUrl: response.data.url.original,
          shortenedUrl: response.data.url.shortened,
          urlError: false
        }))
      })
      .catch((error) => {
        this.setState(state =>  ({
          originalUrl: "",
          shortenedUrl: "",
          urlError: true,
        }))
      });
  }

  render () {
    let urlDetails;

    if (this.state.urlError) {
      urlDetails = <UrlError/>
    } else if (this.state.originalUrl && this.state.shortenedUrl) {
      urlDetails = <UrlInfo
        original={this.state.originalUrl}
        shortened={this.state.shortenedUrl}/>
    }

    return (
      <div className="container">
        <div className="row">
          <div className="col-md-6 col-md-offset-3">
            <h1>{I18n.t('home.index.url-shortener')}</h1>
          </div>
        </div>

        <div className="row">
          <div className="col-md-6 col-md-offset-3">
            <form className="new_url" onSubmit={this.handleSubmit}>
              <FormFields/>
            </form>
          </div>
        </div>

        <div className="row">
          <div className="col-md-6 col-md-offset-3">{urlDetails}</div>
        </div>

        <div className="row">
          <div className="col-md-6 col-md-offset-3">
            <LanguageSelector/>
          </div>
        </div>
      </div>
    );
  }
}

export default Form
