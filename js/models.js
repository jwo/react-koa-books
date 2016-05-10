var Sequelize = require('sequelize');
var sequelize = new Sequelize( process.env.DATABASE_URL || 'postgres://@localhost:5432/IronLibrary_development');

var Book = sequelize.define('books', {
  title: {
    type: Sequelize.STRING
  },
  photoUrl: {
    type: Sequelize.STRING,
    field: 'photo_url'
  },
  authorId: {
    type: Sequelize.INTEGER,
    field: 'author_id'
  }
  }, {
  freezeTableName: true,
  timestamps: false
});

var Author = sequelize.define('authors', {
  firstName: {
    type: Sequelize.STRING,
    field: 'first_name'
  },
  lastName: {
    type: Sequelize.STRING,
    field: 'last_name'
  },
  bio: {
    type: Sequelize.TEXT
  },
  createdAt: {
    type: Sequelize.DATE,
    field: 'created_at'
  },
  updatedAt: {
    type: Sequelize.DATE,
    field: 'updated_at'
  }
})

Book.belongsTo(Author)
Author.hasMany(Book)

module.exports = {
  Book, Author
}
