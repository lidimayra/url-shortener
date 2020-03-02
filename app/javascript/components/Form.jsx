import React from "react";
import PropTypes from "prop-types";
import axios from 'axios';
import I18n from 'i18n-js';

import {UrlError, UrlInfo} from './UrlInfoSection';

class Form extends React.Component {
  constructor(props) {
    I18n.locale = props.locale || "en";

    super(props);
    this.state = {
      hasUrlDivClass: "hidden",
      urlError: "",
      originalUrl: "",
      shortenedUrl: ""
    }

    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit(e) {
    e.preventDefault();

    axios
      .post('/urls', { url: { original: e.target[0].value } })
      .then((response) => {
        this.setState(state =>  ({
          hasUrlDivClass: "",
          hasShortenedUrlClass: "",
          originalUrl: response.data.url.original,
          shortenedUrl: response.data.url.shortened,
          urlError: ""
        }))
      })
      .catch((error) => {
        this.setState(state =>  ({
          hasUrlDivClass: "",
          urlError: I18n.t('home.index.submission-error'),
          hasShortenedUrlClass: "hidden",
          originalUrl: "",
          shortenedUrl: "",
        }))
      });
  }

  render () {
    let urlDetails;

    if (this.state.urlError) {
      urlDetails = <UrlError errorMsg={this.state.urlError}/>
    } else if (this.state.originalUrl && this.state.shortenedUrl) {
      urlDetails = <UrlInfo
        original={this.state.originalUrl}
        shortened={this.state.shortenedUrl}/>
    }

    return (
      <div>
        <div className="row">
          <div className="col-md-6 col-md-offset-3">
            <h1>{I18n.t('home.index.url-shortener')}</h1>
          </div>
        </div>

        <div className="row">
          <div className="col-md-6 col-md-offset-3">
            <form className="new_url" onSubmit={this.handleSubmit} method="post">
              <div className="form-group">
                <label htmlFor="url_original"/>
                  <strong>{I18n.t('home.index.enter-url')}</strong>
                <input className="form-control" type="text" id="url_original"
                name="url[original]" placeholder={I18n.t('home.index.example-url')}/>
              </div>

              <div className="form-group">
                <input type="submit" value={I18n.t('home.index.submit')} className="btn btn-primary"/>
              </div>
            </form>
          </div>
        </div>

        <div className={`row ${this.state.hasUrlDivClass}`}>
          <div className="col-md-6 col-md-offset-3">{urlDetails}</div>
        </div>
      </div>
    );
  }
}

export default Form
