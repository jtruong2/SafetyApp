import React, { Component } from 'react';
import PropTypes from 'prop-types';
import {connect} from 'react-redux'
import Login from './components/Login'
import './App.scss';

class App extends Component {
  render() {
    return (
      <div className="container">
      {
        !this.props.user &&
        <Login />
      }
      </div>
    );
  }
}

App.propTypes = {
  user: PropTypes.shape({
    userId: PropTypes.number.isRequired,
    role: PropTypes.string.isRequired
  })
}

const mapStateToProps = (state) => {
  return {
    user: state.user
  }
}

export {App};
export default connect(mapStateToProps)(App);
