--高速决斗技能-飞蛾扑火
Duel.LoadScript("speed_duel_common.lua")
function c100730184.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730184.operation,c100730184.con,aux.Stringid(100730184,0))
	local e1=Effect.GlobalEffect(c)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c100730184.operation)
	c:RegisterEffect(e1)
	aux.SpeedDuelBeforeDraw(c,c100730184.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730184.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_DECK,0,1,nil,58192742)
		and Duel.GetMZoneCount(tp)>0
end

function c100730184.operation(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local g1=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
	local c=g1:Select(tp,1,1,nil)
	Duel.Hint(HINT_CARD,1-tp,100730184)
	Duel.SendtoDeck(c,nil,1,REASON_RULE)
	local op=Duel.SelectOption(tp,aux.Stringid(100730184,1),aux.Stringid(100730184,2))
	if op==0 then
		local g=Duel.SelectMatchingCard(tp,c100730184.filter,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil)
		if g:GetCount()>0 then
			local d=Duel.CreateToken(tp,40240595)
			Duel.SendtoHand(d,nil,REASON_RULE)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local tc=g:GetFirst()
			local c=e:GetHandler()
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
			e2:SetTargetRange(LOCATION_MZONE,0)
			e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e2:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
			e2:SetValue(aux.imval1)
			Duel.RegisterEffect(e2,tc)
			Duel.ConfirmCards(1-tp,d)
		end
	elseif op==1 then
		Duel.Hint(HINT_CARD,1-tp,100730184)
		local count=Duel.TossCoin(tp,2)
		if count==2 then
			local c=Duel.CreateToken(tp,48579379)
			Duel.SendtoHand(c,tp,REASON_RULE)
		elseif count==1 then
			local c=Duel.CreateToken(tp,14141448)
			Duel.SendtoHand(c,tp,REASON_RULE)
		elseif count==0 then
			local c=Duel.CreateToken(tp,87756343)
			Duel.SendtoHand(c,tp,REASON_RULE)
		end
	end
end

function c100730184.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c100730184.mothfilter)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(1)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end

function c100730184.mothfilter(e,c)
	return c:IsCode(58192742) or c:IsCode(87756343) or c:IsCode(14141448) or c:IsCode(48579379)
end
function c100730184.filter(c)
	return c:IsCode(58192742)
end