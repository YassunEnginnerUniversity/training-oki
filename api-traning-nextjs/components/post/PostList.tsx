import React from 'react'
import PostItem from './PostItem'

const CardList = () => {
  const posts = [1, 2, 3, 4, 5]

  return (
    <div className="space-y-4">
      {posts.map((post, index) => (
        <PostItem key={index}/>
      ))}
    </div>
  )
}

export default CardList