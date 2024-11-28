'use client';

import { createFollow } from '@/actions/follow/createFollow';
import { createUnfollow } from '@/actions/follow/createUnfollow';
import { Button } from '@/components/ui/button';
import { useState } from 'react';

interface followButtonProps {
  userId: string;
  isFollowed: boolean;
}

const FollowButton = ({ userId, isFollowed }: followButtonProps) => {
  const [isFollow, setisFollow] = useState(isFollowed);
  const handleCreateFollow = createFollow.bind(null, String(userId)); // server actionsに引数を渡すためにbindを使用
  const handleCreateUnfollow = createUnfollow.bind(null, String(userId));

  const handleFollow = async () => {
    try {
      if (isFollow) {
        await handleCreateUnfollow();
        setisFollow(false);
      } else {
        await handleCreateFollow();
        setisFollow(true);
      }
    } catch (error) {
      console.error(error);
    }
  };

  return (
    <form action={handleFollow}>
      {isFollow ? (
        <Button
          variant={'secondary'}
          className="rounded-full px-6"
          type={'submit'}
        >
          Unfollow
        </Button>
      ) : (
        <Button className="rounded-full px-6" type={'submit'}>
          Follow
        </Button>
      )}
    </form>
  );
};

export default FollowButton;
