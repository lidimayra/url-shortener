import React from "react"
import PropTypes from "prop-types"
import axios from 'axios';
import I18n from 'i18n-js';

class Form extends React.Component {

  constructor(props) {
    I18n.locale = props.locale || "en";

    super(props);
    this.state = {
      hasUrlDivClass: "hidden",
      hasError: "hidden",
      hasShortenedUrlClass: "hidden",
      urlError: "",
      originalUrl: "",
      shortenedUrl: ""
    }

    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleOriginalUrlChange(e) {
  }

  handleSubmit(e) {
    e.preventDefault();

    axios
      .post('/urls', { url: { original: e.target[0].value } })
      .then((response) => {
        console.log(response);
        this.setState(state =>  ({
          hasUrlDivClass: "",
          hasShortenedUrlClass: "",
          originalUrl: response.data.url.original,
          shortenedUrl: response.data.url.shortened,
          hasError: "hidden",
        }))
      })
      .catch((error) => {
        this.setState(state =>  ({
          hasError: "",
          hasUrlDivClass: "",
          urlError: I18n.t('home.index.submission-error'),
          hasShortenedUrlClass: "hidden",
        }))
      });
  }

  render () {
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
                name="url[original]" placeholder={I18n.t('home.index.example-url')}
                onChange={this.handleOriginalUrlChange} />
              </div>

              <div className="form-group">
                <input type="submit" value={I18n.t('home.index.submit')} className="btn btn-primary"/>
              </div>
            </form>
          </div>
        </div>

        <div className={`row ${this.state.hasUrlDivClass}`}>
          <div className="col-md-6 col-md-offset-3">
            <div className={"alert alert-danger "+this.state.hasError}>
              {this.state.urlError}
            </div>

            <div className={"panel panel-default "+this.state.hasShortenedUrlClass}>
              <div className="panel-heading">
                <span>{I18n.t('activerecord.attributes.url.original')}</span>
                <div id="original" className="text-muted">
                  {this.state.originalUrl}
                </div>
              </div>

              <div className="panel-body">
                <span className="panel-info">
                  {I18n.t('activerecord.attributes.url.shortened')}
                </span>
                <div id="shortened">
                  <a href={this.state.shortenedUrl}>
                    {window.location.href + this.state.shortenedUrl}
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default Form
