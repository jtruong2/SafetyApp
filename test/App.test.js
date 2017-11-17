import React from 'react';
import ReactDOM from 'react-dom';
import { App } from '../src/App';
import Login from '../src/components/Login'
import { shallow } from 'enzyme';

describe('App', () => {
  it('renders the login when user is not logged in', () => {
    const app = shallow(<App />)
    expect(app.find(Login)).toHaveLength(1)
  })

  it('does not render login when user is logged in', () => {
    const app = shallow(<App user={{userId: 1, role: 'supervisor'}} />)
    expect(app.find(Login)).toHaveLength(0)
  })
})
