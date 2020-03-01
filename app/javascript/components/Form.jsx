import React from "react"
import PropTypes from "prop-types"
import axios from 'axios';
class Form extends React.Component {

  constructor(props) {
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
          urlError: "URL: is not a valid URL",
          hasShortenedUrlClass: "hidden",
        }))
      });
  }

  render () {
    return (
      <div>
        <div className="row">
          <div className="col-md-6 col-md-offset-3">
            <h1>URL Shortener</h1>
          </div>
        </div>

        <div className="row">
          <div className="col-md-6 col-md-offset-3">
            <form className="new_url" onSubmit={this.handleSubmit} method="post">
              <div className="form-group">
                <label htmlFor="url_original"/>
                  <strong>Enter an URL to be shortened</strong>
                <input className="form-control" type="text" id="url_original"
                name="url[original]" placeholder="https://www.example.com"
                onChange={this.handleOriginalUrlChange} />
              </div>

              <div className="form-group">
                <input type="submit" value="Make it short" className="btn btn-primary"/>
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
                <span>Original URL</span>
                <div id="original" className="text-muted">
                  {this.state.originalUrl}
                </div>
              </div>

              <div className="panel-body">
                <span className="panel-info">
                  Shortened URL
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
