const _path = 'assets/svgs';

enum SvgPath {
  logo('assets/icons/logo.svg'),
  eye('$_path/ic_eye.svg'),
  eyeSlash('$_path/ic_eye_slashed.svg'),
  book('$_path/ic_book.svg'),
  home('$_path/ic_home.svg'),
  person('$_path/ic_person.svg'),
  savemark('$_path/ic_savemark.svg'),
  search('$_path/ic_search.svg'),
  filter('$_path/ic_filter.svg');

  final String path;
  const SvgPath(this.path);
}
