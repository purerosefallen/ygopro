--高速决斗技能-银河光子
Duel.LoadScript("speed_duel_common.lua")
function c100730166.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730166.skill,c100730166.con,aux.Stringid(100730166,0))
	local e1=Effect.GlobalEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTarget(c100730166.target)
	e1:SetOperation(c100730166.skill)
	c:RegisterEffect(e1)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730166.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
	and Duel.IsExistingMatchingCard(c100730166.filter,tp,LOCATION_HAND,0,1,nil)
end
function c100730166.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x7b,0x55) and c:IsAbleToDeck()
end
function c100730166.filter1(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSetCard(0x7b,0x55) and c:IsAbleToHand()
end
function c100730166.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100730166.filter1,tp,LOCATION_DECK,0,1,nil) end
end
function c100730166.check(g)
	if #g==1 then return true end
	local res=0x0
	if g:IsExists(Card.IsSetCard,1,nil,0x7b) then res=res+0x1 end
	if g:IsExists(Card.IsSetCard,1,nil,0x55) then res=res+0x2 end
	return res~=0x1 and res~=0x2
end
function c100730166.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.IsExistingMatchingCard(Card.IsAttribute,tp,LOCATION_DECK,0,1,nil,0x6f) then
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730166,0))
	else
		Duel.Hint(HINT_CARD,1-tp,100730166)
		local g=Duel.GetMatchingGroup(c100730166.filter,tp,LOCATION_HAND,0,1,nil)
		local c=g:Select(tp,1,1,nil)
		if c then
			Duel.SendtoDeck(c,nil,2,REASON_RULE)
			local g=Duel.GetMatchingGroup(c100730166.filter1,tp,LOCATION_DECK,0,nil)
			if g:GetCount()==0 then return end
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local g1=g:SelectSubGroup(tp,c100730166.check,false,1,1)
			Duel.SendtoHand(g1,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g1)
		end
	end
end
