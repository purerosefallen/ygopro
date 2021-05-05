--高速决斗技能-适者生存
Duel.LoadScript("speed_duel_common.lua")
function c100730225.initial_effect(c)
	if not c100730225.UsedLP then
		c100730225.UsedLP={}
		c100730225.UsedLP[0]=0
		c100730225.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730225.skill,c100730225.con,aux.Stringid(100730225,1))
	aux.SpeedDuelBeforeDraw(c,c100730225.skill2)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730225.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730225,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730225)
		c100730225.UsedLP[tp]=c100730225.UsedLP[tp]+1000
		local g=Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_DECK,0,nil,0x10e)
		if not g or g:GetCount()==0 then return end
		g=g:RandomSelect(tp,1)
		Duel.MoveSequence(g:GetFirst(),0)
		e:Reset()
	end
end

function c100730225.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetMatchingGroupCount(Card.IsSetCard,tp,LOCATION_DECK,0,nil,0x10e)>2
		and aux.DecreasedLP[tp]-c100730225.UsedLP[tp] >= 1000
end
function c100730225.skill2(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730225)
	local tc=Duel.CreateToken(tp,58419204)
	aux.SpeedDuelSendToHandWithExile(tp,tc)
	e:Reset()
end