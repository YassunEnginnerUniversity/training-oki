import Link from 'next/link';
import { getCurrentUser } from '@/actions/user/getCurrentUser';
import LogoutButton from './LogoutButton';

const PageHeader = async () => {
  const currentUser = await getCurrentUser();

  return (
    <header className="border-b fixed top-0 left-0 w-full bg-white dark:bg-gray-950 z-50">
      <div className="container mx-auto flex items-center justify-between px-4 sm:px-6 lg:px-8 py-4">
        <div>
          <h1 className="text-xl font-semibold text-gray-900 dark:text-gray-100">
            API-Traning-Nextjs
          </h1>
        </div>
        <nav className="flex items-center gap-8">
          {currentUser ? (
            <>
              <Link
                href={'/user/' + currentUser.id}
                className="text-base text-gray-700 dark:text-gray-300 hover:text-gray-900 dark:hover:text-white transition-colors"
              >
                {currentUser.username}
              </Link>
              <LogoutButton />
            </>
          ) : (
            <Link
              href={'/login'}
              className="text-base text-gray-700 dark:text-gray-300 hover:text-gray-900 dark:hover:text-white transition-colors"
            >
              ログイン
            </Link>
          )}
        </nav>
      </div>
    </header>
  );
};

export default PageHeader;
