use dep::noir_bigint;


struct Signed_Bigint {
    sign: bool,
    val: noir_bigint::BigUint56,
}


// Create a Signed_Bigint variable easily
fn toSignedBigint(s: bool, v: noir_bigint::BigUint56) -> Signed_Bigint {
    
    let sb = Signed_Bigint {
        sign: s,
        val: v,
    };
    sb
}


// Outputs the Big Int component of a Signed_Bigint
fn val(sb: Signed_Bigint) -> noir_bigint::BigUint56 {
    sb.val
}


// Outputs the sign of a Signed_Bigint 
// true => >0
// false => <0
// the sign of 0 is non consequential
fn sign(sb: Signed_Bigint) -> bool {
    sb.sign
}


// Generates a Signed_Bigint variable with value 0
fn zero() -> Signed_Bigint {
    let b = noir_bigint::BigUint56 { limbs: [0 as u56; noir_bigint::NUM_LIMBS] };
    let sb = Signed_Bigint {
        sign: true,
        val: b,
    };
    sb
}


// Generates a Signed_Bigint variable with value 1
fn one() -> Signed_Bigint {
    let mut b = noir_bigint::BigUint56 { limbs: [0 as u56; noir_bigint::NUM_LIMBS] };
    b.limbs[0] = 1;
    let sb = Signed_Bigint {
        sign: true,
        val: b,
    };
    sb
}


// Generates a Signed_Bigint variable with value -1
fn negative_one() -> Signed_Bigint {
    let mut b = noir_bigint::BigUint56 { limbs: [0 as u56; noir_bigint::NUM_LIMBS] };
    b.limbs[0] = 1;
    let sb = Signed_Bigint {
        sign: false,
        val: b,
    };
    sb
}


// Creates a Signed_Bigint variable with Big Int part same as the specified u56 value
fn from_u56(s: bool, v: u56) -> Signed_Bigint {
    let mut b = noir_bigint::BigUint56 { limbs: [0 as u56; noir_bigint::NUM_LIMBS] };
    b.limbs[0] = v;
    let sb = Signed_Bigint {
        sign: s,
        val: b,
    };
    sb
}


// Create a Signed_Bigint variable from a byte array
fn from_bytes(s: bool, bytes: [u8]) -> Signed_Bigint {
   
    let mut b = noir_bigint::BigUint56::from_bytes(bytes);
    let sb = Signed_Bigint {
        sign: s,
        val: b,
    };

    sb
}


// Converts a Signed_Bigint to its root Byte Array in u8
fn to_bytes(sb: Signed_Bigint) -> (bool, [u8;noir_bigint::MAX_BYTES]) {
    let bytes = sb.val.to_bytes();
    (sb.sign, bytes)
}


// Converts a Signed_Bigint to its root Bit Array 
fn to_bits(sb: Signed_Bigint) -> (bool, [u1;noir_bigint::MAX_BITS]) {
    let bits = sb.val.to_bits();
    (sb.sign, bits)
}


// a == b => 0
// a > b => 1
// a < b => 2
fn compare(sb1: Signed_Bigint, sb2: Signed_Bigint) -> u32 {
    if (sb1.sign != sb2.sign){
        if sb1.sign {
            1
        }
        else {
            2
        }
    }
    else {
        if sb1.val.eq(sb2.val){
            0
        }
        else {
            if sb1.sign {
                if sb1.val.gt(sb2.val){
                    1
                }
                else {
                    2
                }
            }
            else {
                if sb1.val.gt(sb2.val){
                    2
                }
                else {
                    1
                }
            }
        }
        
    }
}


// Returns true if the two Signed_Bigints are equal
fn isEqual(sb1: Signed_Bigint, sb2: Signed_Bigint) -> bool {
    if (sb1.sign != sb2.sign){
        false
    }
    else {
        sb1.val.eq(sb2.val)
    }
}


// Returns false if the two Signed_Bigints are equal
fn isNotEqual(sb1: Signed_Bigint, sb2: Signed_Bigint) -> bool {
    if (sb1.sign != sb2.sign){
        true
    }
    else {
        (!sb1.val.eq(sb2.val))
    }
}


// Returns true if a > b for two Signed_Bigints
fn isGreater(sb1: Signed_Bigint, sb2: Signed_Bigint) -> bool {
    if (sb1.sign != sb2.sign){
        if sb1.sign {
            true
        }
        else {
            false
        }
    }
    else {
        if sb1.sign {
            (sb1.val.gt(sb2.val))
        }
        else {
            (sb1.val.lt(sb2.val))
        }
    }
}


// Returns true if a >= b for two Signed_Bigints
fn isGreaterOrEq(sb1: Signed_Bigint, sb2: Signed_Bigint) -> bool {
    if (sb1.sign != sb2.sign){
        if sb1.sign {
            true
        }
        else {
            false
        }
    }
    else {
        if sb1.sign {
            (sb1.val.gte(sb2.val))
        }
        else {
            (sb1.val.lte(sb2.val))
        }
    }
}


// Returns true if a < b for two Signed_Bigints
fn isLesser(sb1: Signed_Bigint, sb2: Signed_Bigint) -> bool {
    if (sb1.sign != sb2.sign){
        if sb1.sign {
            false
        }
        else {
            true
        }
    }
    else {
        if sb1.sign {
            (sb1.val.lt(sb2.val))
        }
        else {
            (sb1.val.gt(sb2.val))
        }
    }
}


// Returns true if a <= b for two Signed_Bigints
fn isLesserOrEq(sb1: Signed_Bigint, sb2: Signed_Bigint) -> bool {
    if (sb1.sign != sb2.sign){
        if sb1.sign {
            false
        }
        else {
            true
        }
    }
    else {
        if sb1.sign {
            (sb1.val.lte(sb2.val))
        }
        else {
            (sb1.val.gte(sb2.val))
        }
    }
}


// Returns the number of bits in the Big Int component
fn nBits(sb: Signed_Bigint) -> u56 {
    let n = sb.val.nbits();
    n
}


// Adds two Signed_Bigints
fn add(sb1: Signed_Bigint, sb2: Signed_Bigint) -> Signed_Bigint {
    if (sb1.sign == sb2.sign){
        let sum = sb1.val.add(sb2.val);
        let sb = Signed_Bigint {
            sign: sb1.sign,
            val: sum,
        };
        sb
    }
    else {
        if (sb1.val.gte(sb2.val)){
            let diff = sb1.val.sub(sb2.val);
            let sb = Signed_Bigint {
                sign: sb1.sign,
                val: diff,
            };
            sb
        }
        else {
            let diff = sb2.val.sub(sb1.val);
            let sb = Signed_Bigint {
                sign: sb2.sign,
                val: diff,
            };
            sb
        }
    }
}


// Subtracts the second Signed_Bigint from the first
fn subtract(sb1: Signed_Bigint, sb2: Signed_Bigint) -> Signed_Bigint {
    if (sb1.sign != sb2.sign){
        let sum = sb1.val.add(sb2.val);
        let sb = Signed_Bigint {
            sign: sb1.sign,
            val: sum,
        };
        sb
    }
    else {
        if (sb1.val.gte(sb2.val)){
            let diff = sb1.val.sub(sb2.val);
            let sb = Signed_Bigint {
                sign: sb1.sign,
                val: diff,
            };
            sb
        }
        else {
            let diff = sb2.val.sub(sb1.val);
            let sb = Signed_Bigint {
                sign: sb2.sign,
                val: diff,
            };
            sb
        }
    }
}


// Multiplies two Signed_Bigints
fn multiply(sb1: Signed_Bigint, sb2: Signed_Bigint) -> (Signed_Bigint, Signed_Bigint) {
    let mul = sb1.val.mul(sb2.val);
    let sblo = Signed_Bigint {
        sign: (sb1.sign == sb2.sign),
        val: mul.0,
    };
    let sbhi = Signed_Bigint {
        sign: (sb1.sign == sb2.sign),
        val: mul.1,
    };
    (sblo, sbhi)
}


// Divides the first Signed_Bigint by the second, returns the Quotient
fn divide(sb1: Signed_Bigint, sb2: Signed_Bigint) -> Signed_Bigint {
    let div = sb1.val.div(sb2.val);
    let sb = Signed_Bigint {
        sign: (sb1.sign == sb2.sign),
        val: div.0,
    };
    sb
}


// Returns the remainder when the first Signed_Bigint is divided by the second
fn remainder(sb1: Signed_Bigint, sb2: Signed_Bigint) -> Signed_Bigint {
    let div = sb1.val.div(sb2.val);
    let rem = div.1;
    if (sb1.sign == sb2.sign){
        let sb = Signed_Bigint {
            sign: (sb1.sign == sb2.sign),
            val: rem,
        };
        sb
    }
    else {
        let sb = Signed_Bigint {
            sign: (!sb1.sign),
            val: sb2.val.sub(rem),
        };
        sb
    }
    
}


// Left shifts the Signed_Bigint by n places
fn shift_left(sb: Signed_Bigint, n: u56) -> Signed_Bigint {
    assert (n < noir_bigint::MAX_BITS as u56);
    let sh = sb.val.shl(n);
    let res = Signed_Bigint {
        sign: sb.sign,
        val: sh,
    };
    res 
}


// Right shifts the Signed_Bigint by n places
fn shift_right(sb: Signed_Bigint, n: u56) -> Signed_Bigint {
    assert (n < noir_bigint::MAX_BITS as u56);
    let mut res = noir_bigint::BigUint56::zero();

    let mut pow = noir_bigint::BigUint56::one();

    for i in 0..280{
        let mut j = i as u56;
        if j < n {
            let x = from_u56(true, 2);
            let mut temp = pow.mul(x.val);
            pow = temp.0;
        }
    };

    let final_value = sb.val.div(pow);
    let mut r = 0;
    if (!final_value.0.mul(pow).0.eq(sb.val)) {
        r = 1;
    }

    if n < noir_bigint::MAX_BITS as u56 {
        let shift_num = n / (noir_bigint::BITS_PER_LIMB as u56);
        let rem = n % (noir_bigint::BITS_PER_LIMB as u56);

       
        for i in 0..noir_bigint::NUM_LIMBS {
            if i as u56 + shift_num < noir_bigint::NUM_LIMBS as u56 {
                res.limbs[i] = sb.val.limbs[i + shift_num as Field];
            }
        }

        res = res.shr_limb(rem);

        if (!sb.sign){
            if (r != 0 as u56){
                res = res.add(noir_bigint::BigUint56::one());
            }
        } 
    }

    
    let final = Signed_Bigint {
        sign: sb.sign,
        val: res,
    };
    final
}


// Shifts the Signed Bigint one place to the left
fn shift1_left(sb: Signed_Bigint) -> Signed_Bigint {
    let res = shift_left(sb, 1 as u56);
    res
}


// Shifts the Signed Bigint one place to the right
fn shift1_right(sb: Signed_Bigint) -> Signed_Bigint {
    let res = shift_right(sb, 1 as u56);
    res
}


#[test]
fn test_zero(){
    let z = zero();
    assert (z.val.limbs[0] == 0);
}

#[test]
fn test_one(){
    let z = one();
    assert (z.val.limbs[0] == 1);
}

#[test]
fn test_negative_one(){
    let z = negative_one();
    assert (z.val.limbs[0] == 1);
    assert (!z.sign);
}


#[test]
fn test_from_bytes1() {
    let bytes = [2 as u8];
    let a = from_bytes(true, bytes);
    assert(a.val.eq(noir_bigint::BigUint56{ limbs: [2, 0, 0, 0, 0] }));
}

#[test]
fn test_from_bytes2() {
    let bytes = [255 as u8; 7];
    let bi = noir_bigint::BigUint56{ limbs: [-1 as u56, 0, 0, 0, 0] };
    let a = from_bytes(true, bytes);
    let b = Signed_Bigint {
        sign: true,
        val: bi,
    };
    assert(isEqual(a, b));
}

#[test]
fn test_from_bytes3() {
    let bytes = [255 as u8; 8];
    let a = from_bytes(true, bytes);
    let b = Signed_Bigint {
        sign: true,
        val: noir_bigint::BigUint56{ limbs: [-1 as u56, 255, 0, 0, 0] },
    };
    assert(isEqual(a, b));
}



#[test]
fn test_add1() {
    let a = noir_bigint::BigUint56::from_bytes([1]);
    let b = noir_bigint::BigUint56::from_bytes([3]);
    let c = noir_bigint::BigUint56::from_bytes([4]);
    let sb1 = toSignedBigint(true, a);
    let sb2 = toSignedBigint(true, b);
    let sum = add(sb1, sb2);
    let other = toSignedBigint(true, c);
    assert (isEqual(sum, other));
}


#[test]
fn test_add2() {
    let a = noir_bigint::BigUint56::from_bytes([1]);
    let b = noir_bigint::BigUint56::from_bytes([3]);
    let c = noir_bigint::BigUint56::from_bytes([2]);
    let sb1 = toSignedBigint(false, a);
    let sb2 = toSignedBigint(true, b);
    let sum = add(sb1, sb2);
    let other = toSignedBigint(true, c);
    assert (isEqual(sum, other));
}

#[test]
fn test_subtract1() {
    let a = noir_bigint::BigUint56::from_bytes([11]);
    let b = noir_bigint::BigUint56::from_bytes([3]);
    let c = noir_bigint::BigUint56::from_bytes([8]);
    let sb1 = toSignedBigint(true, a);
    let sb2 = toSignedBigint(true, b);
    let diff = subtract(sb1, sb2);
    let other = toSignedBigint(true, c);
    assert (isEqual(diff, other));
}


#[test]
fn test_subtract2() {
    let a = noir_bigint::BigUint56::from_bytes([3]);
    let b = noir_bigint::BigUint56::from_bytes([2]);
    let c = noir_bigint::BigUint56::from_bytes([5]);
    let sb1 = toSignedBigint(false, a);
    let sb2 = toSignedBigint(true, b);
    let diff = subtract(sb1, sb2);
    let other = toSignedBigint(false, c);
    assert (isEqual(diff, other));
}


#[test]
fn test_lshift() {
    let a = from_bytes(true, [1, 2]);
    let b = shift_left(a, 0);

    assert(compare(a, b) == 0);
}

#[test]
fn test_lshift2() {
    let a = from_bytes(true, [1, 2]);
    let b = shift_left(a, 1);

    let bytes = to_bytes(b);

    let mut expected = [0 as u8; noir_bigint::MAX_BYTES];
    expected[0] = 2;
    expected[1] = 4;

    assert(bytes.1 == expected);
}


#[test]
fn test_lshift3() {
    let a = from_u56(true, 6 as u56);
    let b = shift_left(a, 2);

    assert(compare(b, from_u56(true, 24 as u56)) == 0);
}


#[test]
fn test_lshift4() {
    let a = from_u56(false, 6 as u56);
    let b = shift_left(a, 2);

    assert(compare(b, from_u56(false, 24 as u56)) == 0);
}


#[test]
fn test_lshift5() {
    let a = from_bytes(false, [1, 2]);
    let b = shift_left(a, 1);

    let bytes = to_bytes(b);

    let mut expected = [0 as u8; noir_bigint::MAX_BYTES];
    expected[0] = 2;
    expected[1] = 4;

    assert(bytes.1 == expected);
    assert (!bytes.0);
}


#[test]
fn test_rshift() {
    let a = from_bytes(true, [1, 2]);
    let b = shift_right(a, 0);

    assert(compare(a,b) == 0);
}

#[test]
fn test_rshift2() {
    let a = from_bytes(true, [0, 1, 2]);
    let b = shift_right(a, 8);

    assert(compare(b, from_bytes(true, [1, 2])) == 0);
}

#[test]
fn test_rshift3() {
    let a = from_bytes(false, [0, 1, 2]);
    let b = shift_right(a, 8);
    let c = from_bytes(false, [1,2]);
    assert(compare(b, c) == 0); 
    
}

#[test]
fn test_rshift4() {
    let a = from_u56(true, 21 as u56);
    let b = shift_right(a, 2);

    assert(compare(b, from_u56(true, 5 as u56)) == 0);
}


#[test]
fn test_rshift5() {
    let a = from_u56(false, 23 as u56);
    let b = shift_right(a, 3);

    assert(compare(b, from_u56(false, 3 as u56)) == 0);
}


#[test]
fn test_rshift6() {
    let a = from_u56(false, 32 as u56);
    let b = shift_right(a, 2);

    assert(compare(b, from_u56(false, 8 as u56)) == 0);
}

#[test]
fn test_rshift7() {
    let a = from_u56(false, 34 as u56);
    let b = shift_right(a, 2);

    assert(compare(b, from_u56(false, 9 as u56)) == 0);
}