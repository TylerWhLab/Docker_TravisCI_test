import { render, screen } from '@testing-library/react';
import App from './App';

// npm run test 실행 시 호출되는 곳
// learn react 문자열이 대소문자 구분없이 존재하는지 체크, 없으면 에러
test('renders learn react link', () => {
  render(<App />);
  const linkElement = screen.getByText(/learn react/i);
  expect(linkElement).toBeInTheDocument();
});
