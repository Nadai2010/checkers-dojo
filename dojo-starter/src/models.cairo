use starknet::ContractAddress;

#[derive(Copy, Drop, Serde, Debug)]
#[dojo::model]
pub struct Piece {
    #[key]
    pub player: ContractAddress,
    #[key]
    pub coordinates: Coordinates,
    pub position: Position,
    pub is_king: bool,
    pub is_alive: bool,
}

#[derive(Serde, Copy, Drop, Introspect, PartialEq, Debug)]
pub enum Position {
    None,
    Up,
    Down,
}

impl PositionIntoFelt252 of Into<Position, felt252> {
    fn into(self: Position) -> felt252 {
        match self {
            Position::None => 0,
            Position::Up => 1,
            Position::Down => 2,
        }
    }
}

#[derive(Copy, Drop, Serde, IntrospectPacked, Debug)]
pub struct Coordinates {
    pub raw: u32,
    pub col: u32
}

#[generate_trait]
impl PositionImpl of PositionTrait {
    fn is_zero(self: Coordinates) -> bool {
        if self.raw - self.col == 0 {
            return true;
        }
        false
    }

    fn is_equal(self: Coordinates, b: Coordinates) -> bool {
        self.raw == b.raw && self.col == b.col
    }
}
// #[cfg(test)]
// mod tests {
//     use super::{Vec2, Vec2Trait};

//     #[test]
//     fn test_vec_is_zero() {
//         assert(Vec2Trait::is_zero(Vec2 { x: 0, y: 0 }), 'not zero');
//     }

//     #[test]
//     fn test_vec_is_equal() {
//         let coordinates = Vec2 { x: 420, y: 0 };
//         assert(coordinates.is_equal(Vec2 { x: 420, y: 0 }), 'not equal');
//     }
// }


