import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/user_view_model.dart';

final currentUserProvider = StateProvider<UserViewModel>((ref) => UserViewModel());
