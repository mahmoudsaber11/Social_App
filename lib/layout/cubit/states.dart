abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingStates extends SocialStates {}

class SocialGetUserSuccessStates extends SocialStates {}

class SocialGetUserErrorStates extends SocialStates {
  final String error;

  SocialGetUserErrorStates(this.error);
}

class SocialGetAllUsersLoadingStates extends SocialStates {}

class SocialGetAllUsersSuccessStates extends SocialStates {}

class SocialGetAllUsersErrorStates extends SocialStates {
  final String error;

  SocialGetAllUsersErrorStates(this.error);
}

class SocialGetPostSuccessStates extends SocialStates {}

class SocialGetPostErrorStates extends SocialStates {
  final String error;

  SocialGetPostErrorStates(this.error);
}

class SocialLikePostLoadingStates extends SocialStates {}

class SocialLikePostSuccessStates extends SocialStates {}

class SocialLikePostErrorStates extends SocialStates {
  final String error;

  SocialLikePostErrorStates(this.error);
}

class SocialChangeBottomNavStates extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialProfileImageSuccessState extends SocialStates {}

class SocialProfileImageErrorState extends SocialStates {}

class SocialCoverImageSuccessState extends SocialStates {}

class SocialCoverImageErrorState extends SocialStates {}

class SocialUploadProfileImageLoadingState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageLoadingState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

//create post
class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialPostImageSuccessState extends SocialStates {}

class SocialPostImageErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

class DeletePostSuccessState extends SocialStates {}
//create comment

class UpdatePostLoadingState extends SocialStates {}

class GetCommentPicSuccessState extends SocialStates {}

class GetCommentPicErrorState extends SocialStates {}

class GetCommentLoadingState extends SocialStates {}

class GetCommentSuccessState extends SocialStates {}

class UploadCommentPicLoadingState extends SocialStates {}

class UploadCommentPicErrorState extends SocialStates {}

class SocialCommentLoadingState extends SocialStates {}

class SocialCommentSuccessState extends SocialStates {}

class SocialCommentErrorState extends SocialStates {
  final String error;

  SocialCommentErrorState(this.error);
}

class DeleteCommentPicState extends SocialStates {}

//chat
class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {}

class SocialGetMessageSuccessState extends SocialStates {}

class SocialGetMessageErrorState extends SocialStates {}

class GetMessagePicSuccessState extends SocialStates {}

class GetMessagePicErrorState extends SocialStates {}

class DeleteMessagePicState extends SocialStates {}

class UploadMessagePicSuccessState extends SocialStates {}

class UploadMessagePicErrorState extends SocialStates {}

class UploadMessagePicLoadingState extends SocialStates {}

class AppChangeModeStates extends SocialStates {}
