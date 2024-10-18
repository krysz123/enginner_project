enum FriendStatusEnum {
  sendInvite('Wysłane'),
  invitation('Otrzymane'),
  accepted('Zaakceptowane'),
  rejected('Odrzucone');

  final String label;

  const FriendStatusEnum(this.label);
}
