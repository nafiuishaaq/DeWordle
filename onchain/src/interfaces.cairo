use dewordle::constants::LetterState;
use starknet::ContractAddress;

#[starknet::interface]
pub trait IDeWordle<TContractState> {
    fn set_daily_word(ref self: TContractState, word: ByteArray);
    fn get_daily_word(self: @TContractState) -> felt252;
    fn get_daily_letters(self: @TContractState) -> Array<felt252>;

    fn get_player_daily_stat(self: @TContractState, player: ContractAddress) -> DailyPlayerStat;
    fn play(ref self: TContractState);

    fn submit_guess(ref self: TContractState, guessed_word: ByteArray) -> Option<Span<LetterState>>;
}

#[derive(Drop, Serde, starknet::Store)]
pub struct PlayerStat {
    pub player: ContractAddress,
    pub score: u64, //TODO: Impl scoring logic
    pub games_played: u64,
    pub games_won: u64,
    pub current_streak: u64,
    pub max_streak: u64 //TODO: Impl streaking logic
}

#[derive(Drop, Serde, starknet::Store)]
pub struct DailyPlayerStat {
    pub player: ContractAddress,
    pub attempt_remaining: u8,
    pub has_won: bool,
    pub won_at_attempt: u8,
}
