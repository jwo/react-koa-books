import polyfill from "babel-polyfill"

const cluster = require('cluster')
import _router from 'koa-router'
const router = _router()

// middleware
import stat from 'koa-serve-static'
import conditional from 'koa-conditional-get'
import bodyParser from 'koa-bodyparser'
import Compress from 'koa-compress'
import Morgan from 'koa-morgan'
import favicon from 'koa-favicon'
import session from 'koa-session'

// adapt pre Koa 2.0 middle ware to be compatible with Koa 2.0.
import adapt from 'koa-convert'
import etag from 'koa-etag'
import koa from 'koa'
import request from 'request'
import passport from 'koa-passport'
export const app = new koa()

const logger = Morgan('combined')
import rt from 'koa-response-time'

import enforceHttps from 'koa-sslify'
const config = require('../config.json')

if(config.https){
    if(config.heroku){
        app.use(enforceHttps({
            trustProtoHeader: true
        }))
    } else {
        app.use(enforceHttps())
    }
}

//-- app.use(adapt(favicon(require.resolve('./dist/favicon.ico'))))
app.use(adapt(rt()))
app.use(adapt(conditional()))
app.use(adapt(etag()))
app.use(logger)
app.use(adapt(Compress({ flush: require('zlib').Z_SYNC_FLUSH })))
app.keys = [ Array(4).fill(true).map(x => Math.random()+'').join('') ]
app.use(adapt(session({ maxAge: 24 * 60 * 60 * 1000 }, app)))
app.use(adapt(bodyParser()))

/*
Turn on passport (authenticate your users through twitter, etc)
 */

// uncomment to enable passport
// app.use(passport.initialize())
// app.use(passport.session())

// router.get('/logout', ctx => {
//     ctx.logout()
//     ctx.redirect('/')
// })

const authVia = (router, name, success='/', failure='/failure-to-auth') => {
    router.get(`/auth/${name}`, passport.authenticate(name))
    router.get(`/auth/${name}/callback`, passport.authenticate(name, {successRedirect: success, failureRedirect: failure}))
}

// uncomment to enable auth via facebook
// authVia(router, 'facebook')

// uncomment to enable auth via twitter
// authVia(router, 'twitter')

// uncomment to enable auth via google
// authVia(router, 'google')

// uncomment the following to require someone to be logged in, else redirect them to /not-logged-in
// (needed if you turn on any authentication)
//
// app.use((ctx, next) => {
//     if (ctx.isAuthenticated()) {
//         return next()
//     } else {
//         ctx.redirect('/not-logged-in')
//     }
// })

/*
Routes go here
*/

// default proxying
const replaceRemoteTokens = (ctx, webUrl, tokens=webUrl.match(/:(\w+)/ig)) =>
    (tokens || []).reduce((a, t) =>
        a.replace(new RegExp(t, 'ig'), ctx.params[t.substr(1)]), webUrl)

const get = url =>
    new Promise((res,rej) => {
        request({
            url,
            headers: {
                'User-Agent': 'request'
            }
        }, (error, response, body) => {
            if(!error) { // && response.statusCode === 200
                return res(body)
            }
            return rej(error)
        })
    })

const proxify = (router, localUrl, webUrl) => {
    router.get(localUrl, async (ctx, next) => {
        try {
            var data = await get(replaceRemoteTokens(ctx, webUrl) + (ctx.req._parsedUrl.search || ''))
        } catch(e) {
            ctx.body = e
            return
        }
        ctx.body = data
    })

    // router.post(localUrl, async (ctx, next) => {
    //     let data = await request.post(replaceRemoteTokens(ctx.req, webUrl) + ctx.req._parsedUrl.search)//, {form:ctx.req.query})
    //     ctx.body = data
    // })
}

// add your proxies here.
//
// examples:
// proxify(router, '/yummly/recipes', 'http://api.yummly.com/v1/api/recipes')
// proxify(router, '/brewery/styles', 'https://api.brewerydb.com/v2/styles')

const guid = (function() {
    const s4 = () => Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1)
    return () => s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4()
})()

import {Book, Author} from './models';

router.get('/books', ctx => {
  return Book.findAll().then( (books) => {
    ctx.body = {books: books}
  })

})


app.use(router.routes())
app.use(router.allowedMethods())
app.use(stat('dist'))
