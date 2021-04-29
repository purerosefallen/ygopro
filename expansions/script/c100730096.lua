--高速决斗技能-元素合体！
Duel.LoadScript("speed_duel_common.lua")
function c100730096.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730096.skill,c100730096.con,aux.Stringid(100730096,2))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730096.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetMatchingGroup(c100730096.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,nil,tp)
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.GetMZoneCount(tp)>0
		and not Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_MZONE,0,1,nil,25833572)
		and g:GetClassCount(Card.GetCode)>=3
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,25833572)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,2,nil)
end
function c100730096.spfilter(c)
	return c:IsCode(98434877) or c:IsCode(62340868) or c:IsCode(25955164)
end
function c100730096.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730096)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_HAND,0,2,nil)
	local c=g:Select(tp,2,2,nil)
	Duel.SendtoDeck(c,nil,2,REASON_RULE)
	local sg=Duel.GetMatchingGroup(c100730096.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,nil)
	local g1=sg:SelectSubGroup(tp,aux.dncheck,false,3,3)
	local g2=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,25833572)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=g2:GetFirst()
	Duel.SpecialSummonStep(tc,0,tp,tp,true,true,POS_FACEUP)
	local e1=Effect.CreateEffect(tc)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_TYPE)
	e1:SetValue(TYPE_XYZ)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	tc:RegisterEffect(e1,true)
	Duel.Overlay(tc,g1)
	local e2=Effect.CreateEffect(tc)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetReset(RESET_EVENT+RESETS_REDIRECT)
	e2:SetValue(LOCATION_DECKBOT)
	tc:RegisterEffect(e2)
	local e3=Effect.CreateEffect(tc)
	e3:SetDescription(aux.Stringid(100730096,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c100730096.condition)
	e3:SetCost(c100730096.cost)
	e3:SetTarget(c100730096.target)
	e3:SetOperation(c100730096.operation)
	tc:RegisterEffect(e3)
	local e4=Effect.CreateEffect(tc)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTarget(c100730096.reptg)
	tc:RegisterEffect(e4)
	local e5=Effect.CreateEffect(tc)
	e5:SetDescription(aux.Stringid(100730096,0))
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_BATTLE_DESTROYING)
	e5:SetCountLimit(1)
	e5:SetCondition(c100730096.atcon)
	e5:SetCost(c100730096.atcost)
	e5:SetOperation(c100730096.atop)
	tc:RegisterEffect(e5)
	Duel.SpecialSummonComplete()
end
function c100730096.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetAttackTarget()==e:GetHandler()
end
function c100730096.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c100730096.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetAttacker():IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(Duel.GetAttacker())
end
function c100730096.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and tc:GetAttack()>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
function c100730096.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_BATTLE+REASON_EFFECT) and not c:IsReason(REASON_REPLACE) and c:CheckRemoveOverlayCard(tp,1,REASON_EFFECT) end
	if Duel.SelectEffectYesNo(tp,e:GetHandler(),96) then
		c:RemoveOverlayCard(tp,1,1,REASON_EFFECT)
		return true
	else return false end
end
function c100730096.atcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc:IsLocation(LOCATION_GRAVE) and bc:IsType(TYPE_MONSTER) and c:IsChainAttackable() and c:IsStatus(STATUS_OPPO_BATTLE)
end
function c100730096.atcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c100730096.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end
