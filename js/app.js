// es5, 6, and 7 polyfills, powered by babel
import polyfill from "babel-polyfill"

//
// fetch method, returns es6 promises
// if you uncomment 'universal-utils' below, you can comment out this line
import fetch from "isomorphic-fetch"

// universal utils: cache, fetch, store, resource, fetcher, router, vdom, etc
// import * as u from 'universal-utils'
// const {fp,vdom,lazy,hamt,csp,fetch,router} = u,
//     {debounce,m,html,rAF,mount,update,qs,container} = vdom

// the following line, if uncommented, will enable browserify to push
// a changed fn to you, with source maps (reverse map from compiled
// code line # to source code line #), in realtime via websockets
// if (module.hot) {
//     module.hot.accept()
//     module.hot.dispose(() => {
//         app()
//     })
// }

// Check for ServiceWorker support before trying to install it
// if ('serviceWorker' in navigator) {
//     navigator.serviceWorker.register('./serviceworker.js').then(() => {
//         // Registration was successful
//         console.info('registration success')
//     }).catch(() => {
//         console.log('registration failed', e)
//             // Registration failed
//     })
//
//     const unregister = () => navigator.serviceWorker.getRegistrations().then(registrations => {
//         for (let registration of registrations) {registration.unregister()}
//     })
//     window.unregister = unregister
// } else {
//     // No ServiceWorker Support
// }

import DOM from 'react-dom'
import React, {Component} from 'react'

class Book extends React.Component {
  constructor(props){
    super(props);
  }

  render(){
    const book = this.props.book;
    return <div>
      <h3>{book.title}</h3>
      <img src={book.photoUrl} />
    </div>
  }
}

class BookList extends React.Component {

  constructor(props){
    super(props);

    this.state = {
      books: []
    }
  }

  componentDidMount(){
    let component = this;
    fetch("/books")
      .then( (response) => response.json())
      .then( (json) => component.setState({books: json.books}))
  }
  render(){
    return <div>
      {this.state.books.map( (book) => {
        return <Book key={book.id} book={book}/>
      })}
    </div>;
  }
}

function app() {
    // start app
    // new Router()
    DOM.render(<BookList/>, document.querySelector('.container'))
}

app()
