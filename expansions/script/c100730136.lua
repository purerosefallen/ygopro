--高速决斗技能-拟声变化
Duel.LoadScript("speed_duel_common.lua")
function c100730136.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730136.skill,c100730136.con,aux.Stringid(100730136,0))
	local e1=Effect.GlobalEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTarget(c100730136.target)
	e1:SetOperation(c100730136.skill)
	c:RegisterEffect(e1)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730136.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730136.filter,tp,LOCATION_HAND,0,2,nil)
end
function c100730136.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x54,0x59,0x82,0x8f) and c:IsAbleToHand()
end
function c100730136.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100730136.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c100730136.check(g)
	if #g==1 then return true end
	local res=0x0
	if g:IsExists(Card.IsSetCard,1,nil,0x54) then res=res+0x1 end
	if g:IsExists(Card.IsSetCard,1,nil,0x59) then res=res+0x2 end
	if g:IsExists(Card.IsSetCard,1,nil,0x82) then res=res+0x4 end
	if g:IsExists(Card.IsSetCard,1,nil,0x8f) then res=res+0x8 end
	return res~=0x1 and res~=0x2 and res~=0x4 and res~=0x8
end
function c100730136.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730136)
	local g=Duel.GetMatchingGroup(c100730136.filter,tp,LOCATION_HAND,0,2,nil)
	local c=g:Select(tp,2,2,nil)
	if c then
		Duel.SendtoDeck(c,nil,2,REASON_RULE)
		local g=Duel.GetMatchingGroup(c100730136.filter,tp,LOCATION_DECK,0,nil)
		if g:GetCount()==0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g1=g:SelectSubGroup(tp,c100730136.check,false,1,2)
		Duel.SendtoHand(g1,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g1)
	end
end
