--天国之路
function c145581272.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(145581272,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetOperation(c145581272.operation)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(145581272,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_CHAINING)
	e3:SetCountLimit(1)
	e3:SetCondition(c145581272.condition)
	e3:SetCost(c145581272.spcost)
	e3:SetTarget(c145581272.sptg)
	e3:SetOperation(c145581272.spop)
	c:RegisterEffect(e3)
end
function c145581272.condition(e,tp,eg,ep,ev,re,r,rp)
	local race=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_RACE)
	return re:IsActiveType(TYPE_MONSTER) and race&RACE_FAIRY>0
end
function c145581272.cfilter1(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c145581272.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	if not Duel.IsExistingMatchingCard(c145581272.cfilter1,tp,LOCATION_SZONE,0,1,nil,145581273) then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(145581272,2))
		local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,145581273)
		if g:GetCount()>0 then
			Duel.MoveToField(g:GetFirst(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	elseif not Duel.IsExistingMatchingCard(c145581272.cfilter1,tp,LOCATION_SZONE,0,1,nil,145581274) then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(145581272,2))
		local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,145581274)
		if g:GetCount()>0 then
			Duel.MoveToField(g:GetFirst(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	end
end
function c145581272.cfilter2(c,code)
	return c:IsFaceup() and c:IsCode(code) and c:IsAbleToGraveAsCost()
end
function c145581272.cfilter3(c)
	return c:IsFaceup() and c:IsCode(145581272,145581273,145581274) and c:IsAbleToGraveAsCost()
end
function c145581272.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost()
		and Duel.IsExistingMatchingCard(c145581272.cfilter2,tp,LOCATION_SZONE,0,1,nil,145581273)
		and Duel.IsExistingMatchingCard(c145581272.cfilter2,tp,LOCATION_SZONE,0,1,nil,145581274) end
	local g=Duel.GetMatchingGroup(c145581272.cfilter3,tp,LOCATION_SZONE,0,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c145581272.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c145581272.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local res=Duel.TossCoin(tp,1)
	if res==1 then cod=5861892
	else cod=69831560
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c145581272.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)>0 then
		g:GetFirst():CompleteProcedure()
	end
end
function c145581272.spfilter(c,e,tp)
	return c:IsCode(cod) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end