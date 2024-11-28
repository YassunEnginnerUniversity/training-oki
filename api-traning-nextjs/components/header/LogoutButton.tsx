'use client';
import { logout } from '@/actions/auth/logout';
import { Button } from '../ui/button';
import { useRouter } from 'next/navigation';

const LogoutButton = () => {
  const router = useRouter();
  const handleLogout = async () => {
    try {
      await logout();
      router.push('/login');
      router.refresh();
    } catch (error) {
      console.error('ログアウトに失敗しました', error);
    }
  };

  return (
    <Button
      variant="secondary"
      onClick={handleLogout}
      className="justify-self-end"
    >
      ログアウト
    </Button>
  );
};

export default LogoutButton;
